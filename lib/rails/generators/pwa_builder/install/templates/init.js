workbox.setConfig({ debug: false });

workbox.core.setCacheNameDetails({
  prefix: 'my-app',
  suffix: 'v1',
  precache: 'precache',
  runtime: 'runtime-cache'
});
