# Outlet performance dashboard (Vite)

Plain JavaScript + Vite. Data comes from the Supabase table `public.outlet_weekly`;
if Supabase isn't configured or can't be reached, the embedded sample CSV is used.
The subtitle says which ("Data: Supabase" or "sample CSV").

## Run locally

    cp .env.example .env
    npm install
    npm run dev

## Deploy to Vercel

1. Push this folder to a GitHub repo and import it in Vercel (or run `npx vercel` here).
   Vercel detects Vite: build command `npm run build`, output directory `dist`.
2. In Project Settings > Environment Variables add:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY` (publishable key only, never service_role)
3. Redeploy. Vite bakes these values in at build time, so changes need a redeploy.

`supabase-setup.sql` creates and seeds the table if you ever need to rebuild it.
