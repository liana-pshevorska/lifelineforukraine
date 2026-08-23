# Lifeline for Ukraine — website

Static site for [Lifeline for Ukraine Inc.](https://apps.irs.gov/app/eos/), a 501(c)(3)
non-profit (EIN 99-2880632) delivering medical supplies to Ukraine.

Built with **Jekyll** and published by **GitHub Pages' built-in build**. There is no
Node, no build pipeline, and no deploy step: commit to `main` and the site rebuilds itself
in about a minute.

- **To publish an update**, see [POSTING.md](POSTING.md).
- **To change the org's details, donation IDs, or impact numbers**, edit `_config.yml` and
  the files in `_data/` — not the HTML.

---

## Before launch: fill these in

Each is marked `TODO` in the file listed.

| What | Where | Until then |
| --- | --- | --- |
| PayPal **hosted button ID** | `_config.yml` → `donate.paypal_button_id` | The donate card says PayPal is not switched on yet and points donors at Zelle |
| Zelle email address (optional) | `_config.yml` → `donate.zelle_email` | Only the Zelle Tag is shown |
| Public contact email | `_config.yml` → `org.email` | The phone number is shown instead |
| Real impact numbers | `_data/impact.yml` | The homepage shows the word `TODO` |
| Real per-item costs | `_data/tiers.yml` | Placeholder amounts |
| Team / board section, Form 990 link | `about.md` | Section omitted |
| Delete the template post | `_posts/2026-08-22-welcome.md` | A post titled "TEMPLATE" is live |
| Photos | `assets/img/` | Layout works without them |

### Getting the PayPal button ID

Log in to the PayPal nonprofit account → **Pay & Get Paid → PayPal Buttons → Donate**.
Create the button and copy the `hosted_button_id` value out of the code PayPal generates.
**While creating it, turn on the recurring-donation option** — that is what gives donors the
"Make this a monthly donation" checkbox, and monthly donors are worth far more than one-off
gifts. (Recurring is a property of the button itself; the SDK only exposes a `no_recurring`
flag to switch it off, which this site does not set.)
Paste just that ID into `_config.yml`. The page then renders PayPal's official inline
donate button, which supports cards and monthly recurring gifts without the donor leaving
the site. If the SDK is ever blocked by an ad blocker, the card falls back to a
`paypal.com/donate?hosted_button_id=<your id>` link — still specific to this organization.

If PayPal giving is not set up yet, leave `paypal_button_id` empty and the card honestly
says so, pointing donors at Zelle. **Do not** put a bare `https://www.paypal.com/donate`
in `paypal_url` as a placeholder: that is PayPal's generic donation page and will not route
anything to Lifeline, while looking to the donor like it worked. A PayPal.me address for
the organization is a valid `paypal_url`; nothing else is.

### About the Zelle code

Zelle has no web API, button, or payment link — it only works inside bank apps. The QR at
`assets/img/zelle-qr.png` was cropped from the bank-issued code and verified to decode to:

```
https://enroll.zellepay.com/qr-codes?data=<base64>
  → {"name":"LIFELINE FOR UKRAINE INC","action":"payment","token":"lifelineforukraine"}
```

On a phone the image is also a tappable link, so visitors do not have to scan their own
screen. **If the bank ever reissues the code, replace both the image and the `href` in
`_includes/donate-zelle.html`** — they must match.

---

## Deploying to GitHub Pages

One-time setup:

1. Create a **public** repository on GitHub (public is required for free Pages builds).
2. Push this directory to it:
   ```sh
   git remote add origin https://github.com/<user-or-org>/<repo>.git
   git push -u origin main
   ```
3. In the repo: **Settings → Pages → Build and deployment → Source: Deploy from a
   branch**, branch `main`, folder `/ (root)`. Save.
4. Wait a minute or two. The site appears at `https://<user>.github.io/<repo>/`.

### Custom domain

1. **Settings → Pages → Custom domain**, enter e.g. `lifelineforukraine.org`, save.
   GitHub writes a `CNAME` file into the repo for you.
2. At the domain registrar, create these DNS records:
   - `A` records for the apex domain pointing to `185.199.108.153`, `185.199.109.153`,
     `185.199.110.153`, `185.199.111.153`
   - a `CNAME` record for `www` pointing to `<user>.github.io`
3. Back in **Settings → Pages**, tick **Enforce HTTPS** once the certificate is issued
   (can take up to 24 hours).
4. Set `url: "https://lifelineforukraine.org"` in `_config.yml` so social preview cards and
   the RSS feed use absolute links.

---

## Running it locally (optional)

Only needed to preview changes before pushing. macOS ships Ruby 2.6, which is too old, so
install a current Ruby first:

```sh
brew install ruby
export PATH="$(brew --prefix ruby)/bin:$PATH"   # add this to ~/.zshrc to make it stick

bundle install
bundle exec jekyll serve --livereload           # → http://localhost:4000
```

`bundle exec jekyll build` writes the site to `_site/` (git-ignored).

---

## Layout of the project

```
_config.yml      Org details, donation IDs, site settings — the main dial
_data/
  impact.yml     The big numbers on the homepage
  tiers.yml      Suggested giving amounts
  nav.yml        Header and footer links
_layouts/        Page shells (default, page, post, home)
_includes/       Reusable blocks — donate cards, stat band, post cards
_posts/          One Markdown file per update
assets/
  css/main.css   The entire stylesheet
  js/copy.js     Copy-to-clipboard for the Zelle tag
  img/           QR code, favicon, photos
index.html       Homepage
donate.html      Donation page
updates.html     Updates archive
about.md         About page
```

### Design

Navy `#0A2145` with gold `#F5C518`. Gold is reserved for the donate button, section
rules, and stat figures, so it always reads as "give". Body text is Inter with a system
font fallback. All colour pairs meet WCAG AA contrast.
