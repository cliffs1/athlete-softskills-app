import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

Deno.serve(async (req) => {
  try {
    const authHeader = req.headers.get('Authorization')

    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'No authorization header' }),
        { status: 401 }
      )
    }

    // Create normal client using user JWT
    const supabaseUser = createClient(
      Deno.env.get('https://ewsjzgdnxuqtjroehtgy.supabase.co/rest/v1/')!,
      Deno.env.get('ANON_KEY')!,
      {
        global: {
          headers: {
            Authorization: authHeader,
          },
        },
      }
    )

    // Get current user
    const {
      data: { user },
      error: userError,
    } = await supabaseUser.auth.getUser()

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: 'Unauthorized' }),
        { status: 401 }
      )
    }

    // Admin client
    const supabaseAdmin = createClient(
      Deno.env.get('https://ewsjzgdnxuqtjroehtgy.supabase.co/rest/v1/L')!,
      Deno.env.get('SERVICE_ROLE_KEY')!
    )

    // Get profile picture path
    const { data: profile } = await supabaseAdmin
      .from('naudotojas')
      .select('profile_pic_path')
      .eq('auth_user_id', user.id)
      .maybeSingle()

    // Delete profile picture
    if (profile?.profile_pic_path) {
      await supabaseAdmin.storage
        .from('profile_pictures')
        .remove([profile.profile_pic_path])
    }

    // Delete DB row
    await supabaseAdmin
      .from('naudotojas')
      .delete()
      .eq('auth_user_id', user.id)

    // Delete auth user
    await supabaseAdmin.auth.admin.deleteUser(user.id)

    return new Response(
      JSON.stringify({ success: true }),
      { status: 200 }
    )
  } catch (e) {
    return new Response(
      JSON.stringify({ error: e.toString() }),
      { status: 500 }
    )
  }
})