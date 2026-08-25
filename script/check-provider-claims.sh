#!/usr/bin/env bash
# Builds the site under every `donate.provider` state and asserts that the public claims
# match what a donor can actually do.
#
# This exists because the site makes checkable promises — "no processing fees", "100% is
# spent on medical aid", "<provider> emails a receipt" — and those live in prose scattered
# across three pages. Every one of them is derived from _includes/donate-state.html. If you
# add another claim that depends on the provider, add a case here.
#
# Usage:  script/check-provider-claims.sh

set -euo pipefail
cd "$(dirname "$0")/.."
root="$PWD"

# Same Ruby and gem set as script/serve.sh — see the comment in script/preview/Gemfile
# for why the preview does not use the root Gemfile.
brew_ruby="/opt/homebrew/opt/ruby/bin"
if [ -x "$brew_ruby/ruby" ]; then PATH="$brew_ruby:$PATH"; export PATH; fi
export BUNDLE_GEMFILE="$root/script/preview/Gemfile"
if ! bundle check >/dev/null 2>&1; then
  echo "Installing preview gems (first run only)..."
  bundle install
fi
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mk () { # name  provider  zeffy_url  paypal_button_id  paypal_url
  cat > "$tmp/$1.yml" <<YAML
donate:
  provider: "$2"
  zeffy_url: "$3"
  paypal_button_id: "$4"
  paypal_url: "${5:-}"
  zelle_tag: "lifelineforukraine"
  zelle_qr: "/assets/img/zelle-qr.png"
  zelle_email: ""
YAML
  bundle exec jekyll build -s "$root" -d "$tmp/$1" --config "$root/_config.yml,$tmp/$1.yml" -q
}

# name          provider  zeffy_url                        paypal_button_id  paypal_url
mk unconfigured zeffy     ""                               ""
mk zeffy        zeffy     "https://www.zeffy.com/example"  ""
mk paypal       paypal    ""                               "EXAMPLE123"
mk paypalme     paypal    ""                               ""                "https://www.paypal.com/paypalme/example"
mk none         none      ""                               ""

fails=0
want () { # build  file  present|absent  needle  description
  local body; body="$(tr -s '[:space:]' ' ' < "$tmp/$1/$2")"
  case "$3" in
    present) grep -qF -- "$4" <<<"$body" && return 0 ;;
    absent)  grep -qF -- "$4" <<<"$body" || return 0 ;;
  esac
  printf '  FAIL [%s] %s\n' "$1" "$5"
  fails=$((fails + 1))
}

echo "provider: unconfigured zeffy — no card path, so no fee claim may name a provider"
want unconfigured donate/index.html present "Not switched on yet"           'donate page offers the fallback notice'
want unconfigured donate/index.html absent  "emails a receipt"              'no receipt promise without a live provider'
want unconfigured donate/index.html absent  "zeffy.com"                     'no link to an unconfigured form'
want unconfigured index.html        present "By Zelle or check"             'homepage step 2 names only live methods'
want unconfigured about/index.html  present "Zelle and a mailed check"      'about page describes only live methods'

echo "provider: zeffy configured — fee-free, Zeffy sends receipts"
want zeffy donate/index.html present "Zeffy emails a receipt"               'receipt names Zeffy'
want zeffy donate/index.html present "Nothing is deducted on the way"       'fee-free claim present'
want zeffy index.html        present "No processing fees"                   'trust strip claims no fees'
want zeffy index.html        present "By card or Zelle"                     'homepage step 2 includes card'
want zeffy about/index.html  present "A \$35 donation reaches us as \$35"   'about page states the fee-free arithmetic'
want zeffy donate/index.html absent  "PayPal"                               'no PayPal references'

echo "provider: paypal configured — PayPal takes a cut, so no fee-free claim anywhere"
want paypal donate/index.html present "PayPal emails a receipt"             'receipt names PayPal'
want paypal donate/index.html absent  "Nothing is deducted on the way"      'fee-free claim withdrawn'
want paypal index.html        absent  "No processing fees"                  'trust strip drops the no-fee line'
want paypal about/index.html  present "1.99%"                               'about page discloses the rate'
want paypal about/index.html  absent  "reaches us as"                       'no fee-free arithmetic'
want paypal index.html        absent  "buys \$50 of supplies"               'trust strip drops the $50 arithmetic'

echo "provider: paypal via PayPal.me only — still a live PayPal route, still not fee-free"
want paypalme donate/index.html present "paypalme/example"            'links to the org-specific PayPal.me address'
want paypalme donate/index.html present "PayPal emails a receipt"     'receipt names PayPal'
want paypalme donate/index.html absent  "donate-sdk.js"               'no SDK without a hosted button ID'
want paypalme donate/index.html absent  "Nothing is deducted on the way" 'fee-free claim withdrawn'
want paypalme index.html        absent  "No processing fees"          'trust strip drops the no-fee line'
want paypalme index.html        absent  "buys \$50 of supplies"        'no fee-free arithmetic'

echo "provider: none — Zelle and check only, both free"
want none donate/index.html present "Not switched on yet"                   'fallback notice shown'
want none index.html        present "No processing fees"                    'still fee-free'
want none donate/index.html absent  "emails a receipt"                      'no receipt promise'

# The "100% to medical aid" promise must read identically in every provider state.
# It used to live in _data/impact.yml; that file now holds real supply counts, and
# the claim sits in the trust strip on the homepage instead. The assertion follows
# it rather than being dropped — the point was never where it lived.
echo "the 100% claim is worded to hold under every provider"
for b in unconfigured zeffy paypal paypalme none; do
  want "$b" index.html present "No salaries. No overhead." 'the 100% claim is provider-independent'
  want "$b" index.html absent  "taken from your gift"                  'old ambiguous wording is gone'
done

if [ "$fails" -eq 0 ]; then
  echo; echo "OK — every provider state's claims match what a donor can do."
else
  echo; echo "$fails check(s) failed."; exit 1
fi
