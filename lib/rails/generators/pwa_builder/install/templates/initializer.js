export const registerServiceWorker = () => {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/service-worker.js').catch((error) => {
      console.error('Service Worker registration failed', { error });
    });
  }
};
// workbox.setConfig({ debug: false });

// workbox.core.setCacheNameDetails({
//   prefix: 'my-app',
//   suffix: 'v1',
//   precache: 'precache',
//   runtime: 'runtime-cache'
// });
