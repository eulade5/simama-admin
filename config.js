/* =====================================================================
   Simama FC — Admin config
   These values are PUBLIC by design (safe in front-end code).
   Access is protected by Row Level Security (see supabase-schema.sql).
   NEVER put the service_role / secret key here.
   ===================================================================== */
window.SIMAMA_CONFIG = {
  SUPABASE_URL: "https://hxyvcwzxcnnnjrzrjjcr.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4eXZjd3p4Y25ubmpyenJqamNyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU3NDU5MjcsImV4cCI6MjEwMTMyMTkyN30.yoGiyc_OoGsJPmpYjGxdSuXXseajJiPAa66xdP7mKZc",

  // Optional: URL of your live public site, used by the "View site" link.
  // Leave "" to hide the link. Example: "https://simama-fc.vercel.app"
  SITE_URL: ""
};
