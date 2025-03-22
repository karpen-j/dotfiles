return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    local gemini_prompt = [[
      You are the backend of an AI-powered code completion engine. Your task is to
      provide code suggestions based on the user's input. The user's code will be
      enclosed in markers:

      - `<contextAfterCursor>`: Code context after the cursor
      - `<cursorPosition>`: Current cursor location
      - `<contextBeforeCursor>`: Code context before the cursor
    ]]

    local gemini_few_shots = {}

    gemini_few_shots[1] = {
      role = 'user',
      content = [[
        # language: ruby
        <contextBeforeCursor>
        def fibonacci(n)
          <cursorPosition>
        end
        <contextAfterCursor>

        fib(5)
      ]],
    }

    local gemini_chat_input_template = [[
        {{{language}}}
        {{{tab}}}
        <contextBeforeCursor>
        {{{context_before_cursor}}}<cursorPosition>
        <contextAfterCursor>
        {{{context_after_cursor}}}
      ]]

    gemini_few_shots[2] = require('minuet.config').default_few_shots[2]

    require('minuet').setup({
      -- provider = 'claude',
      -- provider_options = {
      --   claude = {
      --     max_tokens = 512,
      --     model = 'claude-3-5-haiku-latest',
      --     stream = true,
      --     api_key = 'ANTHROPIC_API_KEY',
      --   },
      -- },

      provider = 'gemini',
      provider_options = {
        gemini = {
          system = {
            prompt = gemini_prompt,
          },
          few_shots = gemini_few_shots,
          chat_input = {
            template = gemini_chat_input_template,
          },
          model = 'gemini-2.0-flash-lite',
          stream = true,
          api_key = 'GEMINI_API_KEY',
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
              topP = 0.9,
            },
          },
        },
      },
    })
  end,
}
