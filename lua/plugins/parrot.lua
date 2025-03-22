return {
  'frankroeder/parrot.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    'nvim-telescope/telescope.nvim',
  },
  lazy = false,
  config = function()
    require('notify').setup({
      background_colour = '#000000',
      render = 'compact',
      top_down = false,
    })
    require('parrot').setup({
      providers = {
        anthropic = {
          api_key = os.getenv('ANTHROPIC_API_KEY'),
          params = {
            chat = { max_tokens = 6144 },
            command = { max_tokens = 6144 },
          },
        },
        gemini = {
          api_key = os.getenv('GEMINI_API_KEY'),
          params = {
            chat = { max_tokens = 6144 },
            command = { max_tokens = 6144 },
          },
        },
        openai = {
          api_key = os.getenv('OPENAI_API_KEY'),
          params = {
            chat = { max_tokens = 6144 },
            command = { max_tokens = 6144 },
          },
        },
      },
      system_prompt = {
        chat = [[
          You are a web development assistant with deep knowledge of Ruby and Rails. Occasionally, assist with
          JavaScript, HTML, CSS, or Python when required. Provide concise, accurate answers about Ruby, Rails, and
          general web development practices.
        ]],
        command = [[
          Generate practical solutions, snippets, and recommendations for building modern web applications. Include
          context for when and how to use the provided solutions. Include best practices and avoid outdated approaches.
          Keep answers short and concise. Always use line breaks frequently for better readability.
        ]],
      },
      cmd_prefix = 'Prt',
      chat_conceal_model_params = false,
      user_input_ui = 'buffer',
      toggle_target = 'tabnew',
      online_model_selection = true,
      command_auto_select_response = true,
      hooks = {
        RewriteMultiContext = function(prt, params)
          local template = [[
            I have the following code from {{filename}} and other related files:

            ```{{filetype}}
            {{multifilecontent}}
            ```

            Please look at the following section specifically:
            ```{{filetype}}
            {{selection}}
            ```

            Please rewrite this according to the contained instructions.
            Rewrite the selected code above. Respond just with the snippet of code that should replace the selection.
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.rewrite, model_obj, nil, template)
        end,
        CompleteMultiContext = function(prt, params)
          local template = [[
            I have the following code from {{filename}} and other realted files:

            ```{{filetype}}
            {{multifilecontent}}
            ```

            Please look at the following section specifically:
            ```{{filetype}}
            {{selection}}
            ```

            Finish the code above. Respond just with the snippet of code that should be inserted.
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
        end,
        ExplainMultiContext = function(prt, params)
          local template = [[
            Explain the code. Don't mention obvious things. Break down the code's business logic, rules and purpose.
            The goal is to help the reader understand what events and results does the code return.

            ```{{filetype}}
            {{multifilecontent}}
            ```

            Use the markdown format with codeblocks and inline code. Use russian language for explanation.
            Explanation of the code above:
          ]]
          local model = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.enew, model, nil, template)
        end,
        FixBugs = function(prt, params)
          local template = [[
            Fix bugs in the below code from {{filename}}. Your task is to analyze the provided {{filetype}} code
            snippet, identify any bugs or errors present, and provide a corrected version of the code that resolves
            these issues. Explain the problems you found in the original code and how your fixes address them. The
            corrected code should be functional, efficient, and adhere to best practices in {{filetype}} programming.

            ```{{filetype}}
            {{selection}}
            ```

            Fixed code:
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
        end,
        Optimize = function(prt, params)
          local template = [[
            Your task is to analyze the provided {{filetype}} code snippet and suggest improvements to optimize its
            performance. Identify areas where the code can be made more efficient, faster, or less resource-intensive.
            Provide specific suggestions for optimization, along with explanations of how these changes can enhance the
            code's performance. The optimized code should maintain the same functionality as the original code while
            demonstrating improved efficiency.

            ```{{filetype}}
            {{selection}}
            ```

            Optimized code:
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
        end,
        UnitTestsMultiContext = function(prt, params)
          local template = [[
            I have the following code from {{filename}} and other realted files:

            ```{{filetype}}
            {{multifilecontent}}
            ```

            Please look at the following section specifically:
            ```{{filetype}}
            {{filecontent}}
            ```

            Respond by writing unit tests for the code above. Use style from betterspecs if filetype is ruby.
            Use russian language for description of contexts. Do not explain. Do not use markdown.
            Use instance_double instead of receive_message_chain. Use have_received instead of receive.
            Create instances of models via factory_bot instead of mock them.
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
        end,
        Debug = function(prt, params)
          local template = [[
            Review the following code, carefully examine it, and report potential bugs and edge cases alongside
            solutions to resolve them. Keep your explanation short and to the point:

            ```{{filetype}}
            {{selection}}
            ```
          ]]
          local model_obj = prt.get_model('command')
          prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
        end,
      },
      vim.keymap.set({ 'n', 'v', 'x' }, '<leader>ct', ":'<,'>PrtChatToggle<CR>", { desc = 'Prt chat toggle' }),
      vim.keymap.set('n', '<leader>cr', ':PrtChatRespond<CR>', { desc = 'Prt chat response' }),
      vim.keymap.set('v', '<leader>aa', ":'<,'>RewriteMultiContext<CR>", { desc = 'Prt rewrite multicontext' }),
      vim.keymap.set('n', '<leader>at', ':UnitTestsMultiContext<CR>', { desc = 'Prt unit test multicontext' }),
      vim.keymap.set('n', '<leader>fc', ':PrtChatFinder<CR>', { desc = 'Tele find parrot chats' }),
    })
  end,
}
