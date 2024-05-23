export default defineNuxtConfig({
  ssr: false, // Отключаем серверный рендеринг
  app: {
    baseURL: '/solar-credit-calculator/',
  },
  nitro: {
    preset: 'github-pages'
  }
})
