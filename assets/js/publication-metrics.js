(() => {
  const maxAge = 6 * 60 * 60 * 1000;

  document.querySelectorAll('[data-metric-url]').forEach(async (badge) => {
    const endpoint = badge.dataset.metricUrl;
    const cacheKey = `publication-metric:${endpoint}`;
    const valid = (value) => Number.isInteger(value) && value >= 0;
    const display = (record) => {
      badge.querySelector('.metric-value').textContent = record.value.toLocaleString('en-US');
      const date = new Date(record.timestamp).toISOString().slice(0, 10);
      const note = badge.dataset.metricNote ? ` (${badge.dataset.metricNote})` : '';
      badge.title = `${badge.dataset.metricLabel}: ${record.value} as of ${date}${note}`;
    };

    try {
      const cached = JSON.parse(localStorage.getItem(cacheKey));
      if (cached && valid(cached.value) && Number.isFinite(cached.timestamp)
          && cached.timestamp <= Date.now() && Date.now() - cached.timestamp < maxAge) {
        display(cached);
        return;
      }
    } catch (_) {
      // Storage may be unavailable in private browsing; keep the published count.
    }

    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 5000);
    try {
      const response = await fetch(endpoint, { signal: controller.signal, credentials: 'omit' });
      if (!response.ok) return;
      const payload = await response.json();
      const value = payload[badge.dataset.metricField];
      if (!valid(value)) return;
      const record = { value, timestamp: Date.now() };
      display(record);
      try { localStorage.setItem(cacheKey, JSON.stringify(record)); } catch (_) { /* Optional cache. */ }
    } catch (_) {
      // API failures must not replace the dated, verified fallback with zero.
    } finally {
      clearTimeout(timeout);
    }
  });
})();
