# How to post an update

An update is one Markdown file in `_posts/`. Add the file, and GitHub rebuilds and
publishes the site in about a minute. There is nothing to install and nothing to run.

## The 60-second version (in the browser, no software needed)

1. Go to the repository on GitHub and open the **`_posts`** folder.
2. Click **Add file → Create new file**.
3. Name it `YYYY-MM-DD-short-title.md` — for example
   `2026-09-14-kharkiv-delivery.md`. **The date in the filename is required**, and it is
   what orders the post on the site.
4. Paste the template below and edit it.
5. Scroll down, click **Commit changes**.
6. Wait ~60 seconds, then reload the site. The post appears on the homepage, on
   `/updates/`, and in the RSS feed automatically.

## Template — copy this

```markdown
---
title: "120 IFAKs delivered near Kharkiv"
date: 2026-09-14 09:00:00 -0400
location: "Kharkiv oblast"
excerpt: "Our partners confirmed receipt of 120 complete kits, funded by donations received in August."
image: /assets/img/kharkiv-01.jpg
image_alt: "Boxes of first aid kits stacked in the back of a van."
---

Write the update here in plain Markdown. A blank line separates paragraphs.

## A subheading looks like this

- Bullet lists work
- **Bold** and *italic* work
- [Links look like this](https://example.org)
```

Everything above the second `---` is settings; everything below it is the post.

| Setting | Required? | What it does |
| --- | --- | --- |
| `title` | **yes** | Headline, in quotes |
| `date` | **yes** | `YYYY-MM-DD HH:MM:SS -0400` (`-0400` in summer, `-0500` in winter) |
| `excerpt` | recommended | The summary on the homepage card. Without it the first paragraph is used |
| `location` | optional | Shown next to the date |
| `image` | optional | Big photo at the top — see below |
| `image_alt` | if using `image` | Description for screen readers |
| `image_caption` | optional | Caption under the photo |

## Adding photos

1. Open the **`assets/img`** folder on GitHub.
2. **Add file → Upload files**, drag the photo in, **Commit changes**.
3. Reference it in the post as `image: /assets/img/your-file-name.jpg`.

Use lowercase filenames with dashes and no spaces. Resize photos to about 1600px wide
before uploading — a 6MB phone photo makes the page slow to load on a bad connection.

**Before you upload:** check the photo does not show a position, a vehicle plate, unit
insignia, a road sign, or a face that the person did not agree to have published.

## Writing updates that work

The peer organizations that raise the most publish the same four things every time: what
was bought, where it went, what it cost, and what the recipients said. Be specific — "40
tourniquets to a stabilization point in Donetsk oblast" does more than "your donations are
saving lives."

## Fixing a mistake

Open the file on GitHub, click the pencil icon, edit, commit. The site rebuilds again.
To unpublish, delete the file (trash icon) or set the `date` to a future date.
