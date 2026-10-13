# Zotero Research Workflow

[Русский](README.ru.md)

A practical guide to finding, batch-collecting, and analyzing research articles with Zotero and its plugins.
A lifesaver for writing literature reviews.

Linux / Ubuntu · Zotero · Inciteful · OpenAlex · Zotero Scihub · Codex · MCP · Semantic Search

## Why this is needed

The goal is to turn Zotero from a bibliography manager into a research workspace: find related publications from several reference papers, add the works you find in large batches, obtain available PDFs, ask questions of the full texts, search the whole library for passages with a similar meaning, and draft a literature review with Codex.

## Tools

| Tool | Role | Status |
| --- | --- | --- |
| Inciteful for Zotero | Find related work from one paper, several papers, or a collection; citation graph | Core |
| Zotero Connector | Add records from publisher sites, PubMed, and repositories | Core |
| OpenAlex PDF Finder | Attach Unpaywall open-access PDFs to records that already exist, via OpenAlex (in addition to Zotero's native PDF download) | Core |
| Zotero Scihub (`feature/annas-archive-provider`) | Batch-download PDFs for records that have a DOI. This branch adds Anna's Archive beside Sci-Hub; `master` has no such choice | Core |
| llm-for-zotero + Codex CLI | Questions about PDFs, comparison of papers, and extraction of methods; sign in through ChatGPT with no separate API key | Core |
| Zotero Semantic Search | Local meaning-based search across PDF passages, similar documents, MCP | Core |
| Z-Search | Search several sources at once and import results in bulk. Cannot import into separate folders | Optional |

## Workflow

```text
Reference papers in a Zotero collection
        ↓
Inciteful
        ↓
Related publications
        ↓
Batch BibTeX import into Zotero
        ↓
OpenAlex PDF Finder
        ↓
Zotero Scihub
        ↓
Semantic Search / llm-for-zotero + Codex
        ↓
Full-text analysis
```

## Contents

0. [Install Zotero](#en-0)
1. [Inciteful — search from a set of reference papers](#en-1)
2. [Obtain full-text PDFs](#en-2)
3. [OpenAlex PDF Finder](#en-3)
4. [Zotero Scihub](#en-4)
5. [llm-for-zotero + Codex — working with PDF texts without a separate API key](#en-5)
6. [Zotero Semantic Search — local semantic search over PDFs](#en-6)
7. [Z-Search (optional)](#en-7)
8. [Public repository safety](#en-8)
9. [Sources and documentation](#en-9)

<a id="en-0"></a>

## 0. Install Zotero

1. Install [Zotero](https://www.zotero.org/download/) and the [Zotero Connector](https://www.zotero.org/download/connectors).

How to install an `.xpi` plugin: download the file from that project's Releases page → Zotero → Tools → Plugins → gear icon → Install Plugin From File → choose the `.xpi`. Do not download random XPI files from third-party mirrors.

<a id="en-1"></a>

## 1. Inciteful — search from a set of reference papers

- Project: https://github.com/inciteful-xyz/inciteful-zotero-plugin
- Releases: https://github.com/inciteful-xyz/inciteful-zotero-plugin/releases
- Service: https://inciteful.xyz/

### Steps

1. Install an Inciteful build compatible with your Zotero version.
2. Add 5–20 of the most relevant publications to a folder, for example `00_wheat`.
3. Right-click the collection and choose **Graph Search using Inciteful.xyz**. Alternative: select several records → **Inciteful Tools** → **Graph Search**.
4. Read related articles, shared citations, and research clusters via **Inciteful Tools** → **Connect Papers**.
5. Export a suitable set from the web interface to BibTeX and import that file into Zotero, with the target collection selected first.
6. Screen publications by hand or with an LLM against concrete criteria. Citation similarity does not show that the experimental designs match.

<a id="en-2"></a>

## 2. Obtain full-text PDFs

Official Zotero help on attachments and finding PDFs: https://www.zotero.org/support/attaching_files

Finding the remaining records that Zotero could not retrieve is covered in [OpenAlex PDF Finder](#en-3) and in [Zotero Scihub](#en-4).

<a id="en-3"></a>

## 3. OpenAlex PDF Finder

- Project: https://github.com/Littview/zotero-openalex-pdf
- Releases: https://github.com/Littview/zotero-openalex-pdf/releases
- Plugin name in the manifest: **Zotero OpenAlex PDF Finder**

The plugin looks up the selected records in [OpenAlex](https://openalex.org/), finds an open-access copy (publisher, PubMed Central, arXiv, or an institutional repository), and attaches the PDF to that record. Downloading articles requires an API key. A review of 1,000 references makes about 20 requests, and the free allowance is about 1,000 requests a day.

<a id="en-4"></a>

## 4. Zotero Scihub

- Branch to use: https://github.com/ethanwillis/zotero-scihub/tree/feature/annas-archive-provider
- Repository: https://github.com/ethanwillis/zotero-scihub
- Releases: https://github.com/ethanwillis/zotero-scihub/releases

`master` has no PDF-source choice; only Sci-Hub is available by default. Commit [`a88cac8`](https://github.com/ethanwillis/zotero-scihub/commit/a88cac8b0e0b5a7bc6110325a66fd36de77aced0).

### Building the plugin

1. Open **Help → About Zotero**. Install the plugin only if the version is in the 7–10 range this branch declares.
2. Install Node.js 22.x: the branch README names this version as the one that matches CI.
3. Build this branch:

   ```bash
   git clone --branch feature/annas-archive-provider https://github.com/ethanwillis/zotero-scihub.git
   cd zotero-scihub
   npm ci
   npm test
   npm run build
   ```

4. This produces `build/zotero-scihub-<version>.xpi`. Import it into Zotero.
5. Open **Edit → Settings** and the **Zotero Scihub** pane. Leave **PDF source** on **Sci-Hub** unless you mean to select **Anna's Archive**. If you do not want downloads during a large BibTeX import, turn **Automatic PDF Download** off first.

<a id="en-5"></a>

## 5. llm-for-zotero + Codex — questions about PDFs without a separate API key

- Plugin: https://github.com/yilewang/llm-for-zotero
- Releases: https://github.com/yilewang/llm-for-zotero/releases
- Codex CLI: https://github.com/openai/codex
- Authorization reference: https://learn.chatgpt.com/docs/cli/reference

### Recommended path: Codex App Server

1. Make sure Node.js and npm are installed.
2. Install Codex:

   ```bash
   npm install -g @openai/codex
   ```

3. Sign in through the browser with a ChatGPT account:

   ```bash
   codex login
   codex login status
   ```

4. Install the latest llm-for-zotero release compatible with your Zotero version.
5. In Zotero open **Preferences / Settings → llm-for-zotero → Agent**.
6. Enable **Enable Codex App Server integration**, then choose a model and a reasoning level.
7. Open a PDF and try: `Summarize the experimental design and quote the passages supporting sample size, locations, and statistical models.`

Codex App Server is the plugin's link to the Codex CLI installed on this computer. Do not confuse it with the local Semantic Search MCP server in [section 6](#en-6).

This path does not need a separately imported secret key. `codex login` stores the credentials in `~/.codex/auth.json` by itself. Do not copy that file into the repository, into a project `.env`, or onto a public server. Do not print it with `cat`, `jq`, logs, or screenshots. On another computer, sign in again.

Environment check: [scripts/check-codex.sh](scripts/check-codex.sh):

```bash
bash scripts/check-codex.sh
```

If a graphical browser is not available, see `codex login --device-auth` in the CLI documentation.

### Example prompts

```text
For this paper, extract:
- species and number of independent genotypes,
- locations (physical sites, not years or environments),
- years and replicates,
- ANOVA/LMM/BLUP/GBLUP/GWAS model specifications,
- whether each method was applied, compared, or only mentioned,
- exact supporting quotations with page and section.
If a field cannot be verified, return NOT REPORTED instead of guessing.
```

```text
Compare these papers by experimental design and statistical methods.
Do not infer sample size or location count from the abstract if the full text
contains no explicit evidence. Distinguish GEBV from phenotypic predictions.
```

<a id="en-6"></a>

## 6. Zotero Semantic Search — local semantic search over PDFs

- Project: https://github.com/ilDon/zotero-semantic-search
- Releases: https://github.com/ilDon/zotero-semantic-search/releases/latest

1. Install the `.xpi` from Releases.
2. Open **Tools → Semantic Search** (on Linux, Ctrl+Shift+E when that shortcut is free).
3. Download the suggested embedding model and wait until the PDFs are indexed.
4. Search with full phrases, for example: `Genotype was treated as a random effect and year as a fixed effect in a mixed model.`
5. Jump to the matching PDF pages. Use **Find Similar Documents**, and save search results into a collection.

### Optional: connect MCP to an agent

In the Semantic Search settings, enable the local MCP server. Documented address:

```text
http://127.0.0.1:23119/semantic-search/mcp
```

If the MCP client supports Streamable HTTP, point it at that URL. For Codex CLI, when Codex itself should search the indexed library:

```bash
codex mcp add zotero-semantic --url http://127.0.0.1:23119/semantic-search/mcp
codex mcp list
```

This can be useful for integrating the ChatGPT API, DeepSeek, and similar services.

<a id="en-7"></a>

## 7. Z-Search (optional)

- Project: https://github.com/Liozhang/z-search
- Releases: https://github.com/Liozhang/z-search/releases

The plugin searches OpenAlex, Semantic Scholar, PubMed, Europe PMC, and other sources. It can import results and attach PDFs. It is useful for bulk search by words and metadata.

The drawback: mass-imported results are not saved into the nested Zotero collections you want.

<a id="en-8"></a>

## 8. Public repository safety

- Do not commit `~/.codex/auth.json`, `*.env` files with real values, tokens, cookies, Zotero dumps, closed PDFs, private paths, or IP addresses.
- Do not copy the `~/.codex` directory or the Zotero profile into the repository.
- Sign in with `codex login` rather than moving a token by hand. On a remote machine, authorize there through Codex's own sign-in.
- Do not publish screenshots of settings when account identifiers or keys are visible.
- Do not commit OpenAlex API keys, Sci-Hub or Anna's Archive addresses, cookies, or private proxy settings.
- Before publishing, read the file contents and the Git history. `.gitignore` does not erase a secret that is already in history. Revoke that token and issue a new one.

The ignore template is [`.gitignore`](.gitignore). [scripts/check-codex.sh](scripts/check-codex.sh) does not print auth-file contents.

<a id="en-9"></a>

## 9. Sources and documentation

- [Zotero download](https://www.zotero.org/download/) and [Zotero documentation](https://www.zotero.org/support/)
- [Zotero Connector](https://www.zotero.org/download/connectors)
- [Attachments and finding PDFs](https://www.zotero.org/support/attaching_files)
- [Zotero custom PDF resolvers](https://www.zotero.org/support/kb/custom_pdf_resolvers)
- [Inciteful Zotero plugin](https://github.com/inciteful-xyz/inciteful-zotero-plugin) · [releases](https://github.com/inciteful-xyz/inciteful-zotero-plugin/releases) · [inciteful.xyz](https://inciteful.xyz/)
- [OpenAlex PDF Finder](https://github.com/Littview/zotero-openalex-pdf) · [releases](https://github.com/Littview/zotero-openalex-pdf/releases) · [OpenAlex](https://openalex.org/)
- [Zotero Scihub, branch `feature/annas-archive-provider`](https://github.com/ethanwillis/zotero-scihub/tree/feature/annas-archive-provider) · [repository](https://github.com/ethanwillis/zotero-scihub) · [releases](https://github.com/ethanwillis/zotero-scihub/releases)
- [llm-for-zotero](https://github.com/yilewang/llm-for-zotero) · [releases](https://github.com/yilewang/llm-for-zotero/releases)
- [Codex CLI](https://github.com/openai/codex)
- [Codex CLI: login and MCP](https://learn.chatgpt.com/docs/cli/reference)
- [Zotero Semantic Search](https://github.com/ilDon/zotero-semantic-search) · [latest release](https://github.com/ilDon/zotero-semantic-search/releases/latest)
- [Z-Search](https://github.com/Liozhang/z-search) · [releases](https://github.com/Liozhang/z-search/releases)
- [PubMed Central](https://www.ncbi.nlm.nih.gov/pmc/)
- [Europe PMC](https://europepmc.org/)

## License

The guide text may be shared under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Rights in third-party plugins, PDFs, and images belong to their authors.
