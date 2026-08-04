# Simama FC ⚽

A football club for kids who once slept on Kigali's streets — with a mission to build a team in every district in Rwanda.

This is the club's website: a single, self-contained `index.html` (HTML + CSS + JS, no build step). It works the moment you open it.

**Stand up. Play on.**

---

## Quick start

Just open `index.html` in any browser. That's it — everything's in one file.

---

## Host it on GitHub Pages (free)

1. **Create a repo** on GitHub, e.g. `simama-fc`.
2. **Upload these files** (`index.html`, `.nojekyll`, `.gitignore`, `README.md`) — drag them into the repo's *Add file → Upload files*, or push from the command line:
   ```bash
   git init
   git add .
   git commit -m "Simama FC website"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/simama-fc.git
   git push -u origin main
   ```
3. In the repo, go to **Settings → Pages**.
4. Under **Build and deployment → Source**, choose **Deploy from a branch**.
5. Pick branch **`main`**, folder **`/ (root)`**, and click **Save**.
6. Wait ~1 minute. Your site goes live at:
   ```
   https://YOUR-USERNAME.github.io/simama-fc/
   ```

> The `.nojekyll` file is already included so GitHub serves the site as-is.

### Custom domain (optional)
If you have a domain (e.g. `simamafc.org`): add a file named `CNAME` containing just your domain, then set the DNS records GitHub shows you under **Settings → Pages → Custom domain**.

---

## The database (Supabase) — one-time setup

Content (players, news, photos, fundraising numbers) lives in a Supabase
database and is managed from `admin.html`. Do this once:

1. **Run the schema.** In your Supabase dashboard, open **SQL Editor → New query**,
   paste the whole of `supabase-schema.sql`, and click **Run**. This creates the
   tables, storage buckets and security rules, and adds a few starter rows.
2. **Create your admin login.** Go to **Authentication → Users → Add user**.
   Enter an email + password and tick **Auto Confirm User**. Repeat for each
   admin. (Public sign-up stays off, so no one can register themselves.)
3. **Check your keys.** `config.js` already holds this project's URL and public
   (`anon`) key. If you ever move projects, update the two values there. Never put
   the `service_role` / secret key in these files.

That's it. The keys in `config.js` are meant to be public — the database is
protected by Row Level Security (anyone can read the site; only a logged-in
admin can change anything).

---

## Using the admin panel

Open `admin.html` (e.g. `https://YOUR-USERNAME.github.io/simama-fc/admin.html`)
and sign in. From there you can:

- **Players** — add/edit/delete players, with an optional photo.
- **News** — post articles (markdown body, cover image, publish date), edit or delete.
- **Gallery** — upload photos, add captions, mark one as a "featured" big tile.
- **Fundraising & Stats** — set the goal, amount raised, and the four scoreboard numbers.

Everything you change shows up on the public site immediately. No code editing,
no redeploying.

---

## Real donations (when you're ready)

The Donate button is a placeholder link. To take real money, point it at a
payment provider — search `index.html` for `>>> GO LIVE`:

- **Rwanda / Mobile Money + cards:** [IremboPay](https://irembopay.com) or [Flutterwave](https://flutterwave.com) (MTN & Airtel MoMo).
- **International / diaspora:** [Stripe](https://stripe.com) or a PayPal.me link.

Set the button's `href` to your payment/checkout link. You can pass the selected
tier amount along too (there's a commented example in the code).

---

## Files

| File | What it is |
|------|-----------|
| `index.html` | The public website (loads live from the database) |
| `admin.html` | Login + dashboard to manage content |
| `config.js` | Your Supabase URL + public key |
| `supabase-schema.sql` | Run once in Supabase to create the database |
| `.nojekyll` | Lets GitHub Pages serve everything as-is |

## Tech
Plain HTML/CSS/JS + the Supabase JS client (loaded from a CDN). Fonts: Anton,
Manrope, Space Mono. No build step, no framework — hosts free on GitHub Pages.

© Simama FC · Kigali, Rwanda
