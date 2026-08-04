# Simama FC — Admin (standalone)

The login + dashboard for managing the Simama FC site: players, news, gallery,
and the fundraising/scoreboard numbers. It's a self-contained site — it only
talks to your Supabase database, so it can live in its own repo, separate from
the public site.

The admin panel **is** `index.html` here, so the repo's root URL opens the login
directly.

## Files
- `index.html` — the admin login + dashboard
- `config.js` — your Supabase URL + public (anon) key, and an optional link to your live site
- `supabase-schema.sql` — run once in Supabase to build the database
- `.nojekyll` — lets GitHub Pages serve everything as-is

## Host it on GitHub Pages
1. Create a **new repo**, e.g. `simama-admin`.
2. Upload these files (include the hidden `.nojekyll`), or push:
   ```bash
   git init
   git add .
   git commit -m "Simama FC admin"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/simama-admin.git
   git push -u origin main
   ```
3. Repo → **Settings → Pages** → Source: **Deploy from a branch** → **main / (root)** → **Save**.
4. After ~1 minute your admin is live at:
   ```
   https://YOUR-USERNAME.github.io/simama-admin/
   ```

## One-time database setup
1. Supabase dashboard → **SQL Editor → New query** → paste all of
   `supabase-schema.sql` → **Run**.
2. **Authentication → Users → Add user** → email + password → tick
   **Auto Confirm User**. Add one per admin. (Public sign-up stays off, so only
   people you add can log in.)

> If you already ran the schema when setting up the public site, you don't need
> to run it again — the database is shared.

## Optional: link back to your live site
Open `config.js` and set `SITE_URL` to your public site's address, e.g.
`"https://simama-fc.vercel.app"`. That turns on the **"View site ↗"** link in
the top bar. Leave it `""` to hide the link.

## Security note
The key in `config.js` is the **public (anon)** key and is meant to live in the
browser. Row Level Security protects the data: anyone can read the public site,
only a logged-in admin can change anything. Never put the `service_role` /
secret key here.

© Simama FC · Kigali, Rwanda
