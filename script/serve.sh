#!/usr/bin/env bash
# Preview the site locally at http://localhost:4000, rebuilding as you save.
#
# Usage:  script/serve.sh [--port N]
#
# Everything this needs is pinned in script/preview/Gemfile — read the comment
# at the top of that file for why the preview does not use the root Gemfile.
set -euo pipefail
cd "$(dirname "$0")/.."
root="$PWD"

# Homebrew's Ruby is not on PATH by default: macOS ships Ruby 2.6 as /usr/bin/ruby
# and it wins. Jekyll needs 3.x or newer, so put Homebrew's first for this script
# only, rather than editing anyone's shell profile.
brew_ruby="/opt/homebrew/opt/ruby/bin"
if [ -x "$brew_ruby/ruby" ]; then
  PATH="$brew_ruby:$PATH"
  export PATH
fi

if ! ruby -e 'exit(RUBY_VERSION.split(".").first.to_i >= 3)' 2>/dev/null; then
  echo "error: need Ruby 3 or newer; found $(ruby -v 2>/dev/null || echo 'no ruby')" >&2
  echo "       install it with:  brew install ruby" >&2
  exit 1
fi

export BUNDLE_GEMFILE="$root/script/preview/Gemfile"

# Gems go under the project, not into the Ruby install. On a machine where
# Homebrew was installed by a different account, /opt/homebrew/lib/ruby is not
# writable by you, and a system-wide `bundle install` fails partway through with
# a confusing per-gem error. A local path sidesteps that entirely.
bundle config set --local path "$root/vendor/preview" >/dev/null

if ! bundle check >/dev/null 2>&1; then
  echo "Installing preview gems (first run only)..."
  bundle install
fi

port=4000
if [ "${1:-}" = "--port" ] && [ -n "${2:-}" ]; then port="$2"; fi

echo "Serving on http://localhost:$port  — ctrl-c to stop"
exec bundle exec jekyll serve --source "$root" --destination "$root/_site" \
     --port "$port" --watch --livereload
