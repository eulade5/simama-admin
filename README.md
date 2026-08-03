# Simama FC — Admin panel

The login + dashboard for managing the Simama FC site: players, news, gallery,
and the fundraising/scoreboard numbers. It talks to your Supabase database.

## Files
- `admin.html` — the login screen + dashboard
- `config.js` — your Supabase URL + public (anon) key
- `supabase-schema.sql` — run this once in Supabase to build the database

> These 3 files also ship inside the full site zip (`simama-fc`). Keep
> `admin.html` and `config.js` in the **same folder** as your `index.html`
> so the "View site" link and shared config work.

## Setup (once)
1. **Build the database.** Supabase dashboard → **SQL Editor → New query** →
   paste all of `supabase-schema.sql` → **Run**.
2. **Create your login.** **Authentication → Users → Add user** → email +
   password → tick **Auto Confirm User**. Add one per admin. (Public sign-up
   stays off — only people you add can log in.)
3. Put these files next to `index.html`, push to your host, and open
   `admin.html` (e.g. `https://YOUR-USERNAME.github.io/simama-fc/admin.html`).

## What you can do
- **Players** — add/edit/delete, optional photo (a number tile shows until you add one).
- **News** — post articles with a markdown body, cover image and publish date.
- **Gallery** — upload photos, add captions, flag one as a big "featured" tile.
- **Fundraising & Stats** — goal, amount raised, and the four scoreboard numbers.

Changes appear on the public site immediately — no code editing.

## Security note
The key in `config.js` is the **public (anon)** key and is meant to live in the
browser. Row Level Security protects the data: anyone can read the site, only a
logged-in admin can change it. Never put the `service_role` / secret key here.

© Simama FC · Kigali, Rwanda
