// Apne Supabase project ka URL aur anon public key yahan likhein
// (Dashboard -> Project Settings -> API)
const PROJECTURL = ``;
const ANON_PUBLIC_KEY = ``;

const supabase = window.supabase.createClient(PROJECTURL, ANON_PUBLIC_KEY);
export default supabase;
