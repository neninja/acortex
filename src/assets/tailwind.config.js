// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/acorte_web.ex",
    "../lib/acorte_web/**/*.*ex"
  ],
  theme: {
    fontFamily: {
      sans: ['Inter', 'Geist', 'sans-serif']
    },
    extend: {
      colors: {
        neutral: {
          low: {
            DEFAULT: "#000000",
            light: "#A3A3A3",
            medium: "#666666",
            dark: "#292929",
          },
          high: {
            DEFAULT: "#FFFFFF",
            light: "#F5F5F5",
            medium: "#E0E0E0",
            dark: "#CCCCCC",
          },
        },
        highlight: {
          DEFAULT: "#FF51A0",
          light: "#FFC0DC",
          medium: "#B10E58",
          dark: "#5A042B",
        },
        success: {
          DEFAULT: "#0087FF",
          light: "#C2EDFF",
          medium: "#0573B0",
          dark: "#024054",
        },
        warning: {
          DEFAULT: "#FDC800",
          light: "#FFEFB2",
          medium: "#A98D21",
          dark: "#463907",
        },
        error: {
          DEFAULT: "#FF0000",
          light: "#FFC2C2",
          medium: "#CC0000",
          dark: "#7A0000",
        },
        primary: {
          DEFAULT: "#000000",
          light: "#A3A3A3",
          medium: "#666666",
          dark: "#292929",
        },
        secondary: {
          DEFAULT: "#000000",
          light: "#A3A3A3",
          medium: "#666666",
          dark: "#292929",
        },
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, { values })
    })
  ]
}
