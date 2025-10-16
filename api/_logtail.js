// Minimal Logtail (Better Stack) HTTP logger for Vercel Serverless
// Uses LOGTAIL_SOURCE_TOKEN from env. No-op if token missing.

const LOGTAIL_ENDPOINT = 'https://in.logtail.com';

async function logtail(message, level = 'info', context = {}) {
  try {
    const token = process.env.LOGTAIL_SOURCE_TOKEN;
    if (!token) return; // silently skip if not configured

    const payload = {
      dt: new Date().toISOString(),
      level,
      message,
      ...context,
    };

    await fetch(LOGTAIL_ENDPOINT, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify(payload),
    });
  } catch (err) {
    // avoid throwing from logger in serverless
    console.warn('[logtail] send failed', err);
  }
}

module.exports = { logtail };

