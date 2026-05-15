return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
        keymap = { preset = 'super-tab' },
        cmdline = { keymap = { preset = 'cmdline' } },
        completion = {
            accept = { auto_brackets = { enabled = false }, },
            trigger = {
                show_on_keyword = true,
                show_on_trigger_character = true,
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        signature = { enabled = true }
    },
}
