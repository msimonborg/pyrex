// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  safelist: [
    'bg-red-100',
    'text-red-800',
    'bg-blue-100',
    'text-blue-800',
    'bg-yellow-100',
    'text-yellow-800'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          'Ubuntu Mono',
          'Roboto',
          ...defaultTheme.fontFamily.sans,
        ]
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
