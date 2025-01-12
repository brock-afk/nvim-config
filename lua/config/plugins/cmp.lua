return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
        keymap = { preset = 'super-tab' },
        completion = {
            accept = { auto_brackets = { enabled = false }, },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        signature = { enabled = true }
    },
}
