-- LuaSnip
local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep


-- Helpers

local function visual(_, parent)
  return sn(nil, {
    i(1, parent.snippet.env.TM_SELECTED_TEXT or ""),
  })
end


-- LaTeX snippets

ls.add_snippets("tex", {
  s("template", {
    t({
      "\\documentclass[11pt]{article}",
      "",
      "\\usepackage[T1]{fontenc}",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage[english]{babel}",
      "\\usepackage{microtype}",
      "\\usepackage{amsmath,amssymb,amsfonts,mathtools,bm}",
      "\\usepackage[a4paper,margin=1in]{geometry}",
      "\\usepackage{parskip}",
      "\\usepackage{xcolor,graphicx,enumitem}",
      "\\usepackage[mmddyyyy]{datetime}",
      "\\usepackage[colorlinks=true,linkcolor=blue,urlcolor=blue,citecolor=blue]{hyperref}",
      "",
      "\\renewcommand{\\dateseparator}{/}",
      "",
      "\\graphicspath{{images/}}",
      "",
      "\\newcommand{\\notetitle}{NOTES}",
      "",
      "\\begin{document}",
      "",
      "\\begin{titlepage}",
      "    \\centering",
      "    \\vspace*{0.35\\textheight}",
      "    \\resizebox{0.95\\textwidth}{!}{\\textbf{\\notetitle}}",
      "    \\vspace*{\\fill}",
      "\\end{titlepage}",
      "",
      "",
      "\\end{document}",
    }),
  }),
})


ls.add_snippets("tex", {
  s("labtemplate", {
    t({
      "\\documentclass[12pt]{article}",
      "",
      "\\usepackage[letterpaper, margin=0.8in]{geometry}",
      "\\usepackage{amsmath, amssymb, amsthm}",
      "\\usepackage{graphicx}",
      "\\usepackage{booktabs}",
      "\\usepackage{siunitx}",
      "\\usepackage{float}",
      "\\usepackage{caption}",
      "\\usepackage{subcaption}",
      "\\usepackage{hyperref}",
      "\\usepackage[mmddyyyy]{datetime}",
      "",
      "\\renewcommand{\\dateseparator}{/}",
      "",
      "\\graphicspath{{images/}}",
      "",
      "\\setlength{\\parindent}{0pt}",
      "\\setlength{\\parskip}{0.8em}",
      "",
      "\\hypersetup{",
      "    colorlinks=true,",
      "    linkcolor=blue,",
      "    urlcolor=blue,",
      "    citecolor=blue",
      "}",
      "",
      "\\newcommand{\\school}{Stony Brook University}",
      "\\newcommand{\\department}{Department of Physics and Astronomy}",
      "\\newcommand{\\name}{Nelson Mei}",
      "\\newcommand{\\ta}{Manas Choudhary}",
      "\\newcommand{\\labsection}{PHY 252 L03}",
      "\\newcommand{\\labtitle}{title}",
      "\\newcommand{\\expdate}{date}",
      "",
      "\\begin{document}",
      "",
      "\\begin{titlepage}",
      "  \\centering",
      "  \\vspace*{-15mm}",
      "  {\\Large\\textsc{\\school}}\\\\",
      "  {\\Large\\textsc{\\department}}\\\\[10mm]",
      "  {\\Large\\textsc{\\labsection}}",
      "  \\vfill",
      "  {\\Huge\\textbf{\\labtitle}}\\\\[8mm]",
      "  {\\Large\\name}\\\\[10mm]",
      "  {\\Large TA: \\ta}",
      "  \\vfill",
      "  {\\large Experiment Date: \\expdate}\\\\[2mm]",
      "  {\\large Report Date: \\today}\\\\[8mm]",
      "\\end{titlepage}",
      "",
    }),

    i(1),

    t({
      "",
      "\\end{document}",
    }),
  }),
})


ls.add_snippets("tex", {

  s("beg", {
    t("\\begin{"),
    i(1),
    t("}"),

    t({
      "",
      "\t",
    }),

    i(2),

    t({
      "",
      "\\end{",
    }),

    rep(1),

    t("}"),
  }),


  s("enum", {
    t({
      "\\begin{enumerate}",
      "\t\\item ",
    }),

    i(1),

    t({
      "",
      "\\end{enumerate}",
    }),
  }),


  s("item", {
    t({
      "\\begin{itemize}",
      "\t\\item ",
    }),

    i(1),

    t({
      "",
      "\\end{itemize}",
    }),
  }),


  s("dm", {
    t({
      "\\[",
      "\t",
    }),

    d(1, visual),

    t({
      "",
      "\\]",
    }),
  }),


  s("frac", {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),

  -- Your original // fraction shortcut
  s("//", {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),


  s("sq", {
    t("\\sqrt{"),
    i(1),
    t("}"),
  }),

  s("__", {
    t("_{"),
    i(1),
    t("}"),
  }),

  s("td", {
    t("^{"),
    i(1),
    t("}"),
  }),

  s("ooo", {
    t("\\infty"),
  }),

  s("lim", {
    t("\\lim_{"),
    i(1, "n"),
    t(" \\to "),
    i(2, "\\infty"),
    t("} "),
    i(0),
  }),

  s("sum", {
    t("\\sum_{"),
    i(1, "n=1"),
    t("}^{"),
    i(2, "\\infty"),
    t("} "),
    i(3),
  }),

  s("dint", {
    t("\\int_{"),
    i(1, "-\\infty"),
    t("}^{"),
    i(2, "\\infty"),
    t("} "),
    i(3),
  }),

  s("part", {
    t("\\frac{\\partial "),
    i(1, "V"),
    t("}{\\partial "),
    i(2, "x"),
    t("}"),
  }),


  s("=>", { t("\\implies") }),
  s("=<", { t("\\impliedby") }),
  s("iff", { t("\\iff") }),
  s("!=", { t("\\neq") }),
  s("<=", { t("\\le") }),
  s(">=", { t("\\ge") }),

  s("->", { t("\\to") }),
  s("<->", { t("\\leftrightarrow") }),
  s("!>", { t("\\mapsto") }),

  s("xx", { t("\\times") }),
  s("**", { t("\\cdot") }),
  s(">>", { t("\\gg") }),
  s("<<", { t("\\ll") }),
  s("~~", { t("\\sim") }),
  s("||", { t("\\mid") }),

  s("...", { t("\\ldots") }),


  s("set", {
    t("\\{"),
    i(1),
    t("\\}"),
  }),

  s("inn", { t("\\in") }),
  s("notin", { t("\\not\\in") }),
  s("cc", { t("\\subset") }),
  s("UU", { t("\\cup") }),
  s("Nn", { t("\\cap") }),
  s("OO", { t("\\varnothing") }),


  s("NN", { t("\\mathbb{N}") }),
  s("ZZ", { t("\\mathbb{Z}") }),
  s("QQ", { t("\\mathbb{Q}") }),
  s("RR", { t("\\mathbb{R}") }),


  s("pmat", {
    t("\\begin{pmatrix} "),
    i(1),
    t(" \\end{pmatrix}"),
  }),

  s("bmat", {
    t("\\begin{bmatrix} "),
    i(1),
    t(" \\end{bmatrix}"),
  }),


  s("lr", {
    t("\\left("),
    i(1),
    t("\\right)"),
  }),

  s("lr|", {
    t("\\left|"),
    i(1),
    t("\\right|"),
  }),

  s("lr[", {
    t("\\left["),
    i(1),
    t("\\right]"),
  }),

  s("lr{", {
    t("\\left\\{"),
    i(1),
    t("\\right\\}"),
  }),


  s("conj", {
    t("\\overline{"),
    i(1),
    t("}"),
  }),

  s("bar", {
    t("\\overline{"),
    i(1),
    t("}"),
  }),

  s("hat", {
    t("\\hat{"),
    i(1),
    t("}"),
  }),

  s("norm", {
    t("\\|"),
    i(1),
    t("\\|"),
  }),

  s("mcal", {
    t("\\mathcal{"),
    i(1),
    t("}"),
  }),

  s("nabl", {
    t("\\nabla"),
  }),

  s("lll", {
    t("\\ell"),
  }),

  s("tt", {
    t("\\text{"),
    i(1),
    t("}"),
  }),


  s("xnn", { t("x_{n}") }),
  s("ynn", { t("y_{n}") }),
  s("xii", { t("x_{i}") }),
  s("yii", { t("y_{i}") }),
  s("xjj", { t("x_{j}") }),
  s("yjj", { t("y_{j}") }),
  s("xp1", { t("x_{n+1}") }),
  s("xmm", { t("x_{m}") }),


  s("case", {
    t({
      "\\begin{cases}",
      "\t",
    }),

    i(1),

    t({
      "",
      "\\end{cases}",
    }),
  }),


  s("ali", {
    t({
      "\\begin{align*}",
      "\t",
    }),

    i(1),

    t({
      "",
      "\\end{align*}",
    }),
  }),


  s("fig", {
    t({
      "\\begin{figure}[H]",
      "\t\\centering",
      "\t\\includegraphics[width=0.8\\textwidth]{",
    }),

    i(1, "figure"),

    t({
      "}",
      "\t\\caption{",
    }),

    i(2, "caption"),

    t({
      "}",
      "\t\\label{fig:",
    }),

    i(3, "label"),

    t({
      "}",
      "\\end{figure}",
    }),
  }),


  s("HH", {
    t("\\mathbb{H}"),
  }),


  s("DD", {
    t("\\mathbb{D}"),
  }),


  s("today", {
    t(os.date("%m/%d/%Y")),
  }),



})

-- LuaSnip navigation for .tex files only

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function(args)
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
        return
      end

      -- Insert a normal Tab without triggering this mapping again
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
        "n",
        false
      )
    end, {
      buffer = args.buf,
      silent = true,
      desc = "LuaSnip expand or jump",
    })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
        return
      end

      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true),
        "n",
        false
      )
    end, {
      buffer = args.buf,
      silent = true,
      desc = "LuaSnip jump backward",
    })
  end,
})
