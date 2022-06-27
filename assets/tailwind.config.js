// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
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
