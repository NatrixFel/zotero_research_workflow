# Zotero Research Workflow

[English](README.md)

Практический гайд по поиску, массовому сбору и анализу научных статей с помощью Zotero и его плагинов.
Палочка-выручалочка для написания литобзоров.

Linux / Ubuntu · Zotero · Inciteful · Z-Search · OpenAlex · Zotero Scihub · Codex · MCP · Semantic Search

## Зачем это нужно

Цель — превратить Zotero из менеджера библиографии в исследовательское рабочее пространство: находить связанные публикации по нескольким эталонным статьям, добавлять найденные работы сразу большими партиями, получать доступные PDF, задавать вопросы к полным текстам, искать похожие по смыслу фрагменты по всей библиотеке, формировать литобзор с помощью Codex.

## Инструменты

| Инструмент | Задача | Статус |
| --- | --- | --- |
| Inciteful for Zotero | Поиск связанных работ по статье, нескольким статьям или коллекции; граф цитирований | Основной |
| Zotero Connector | Добавление записей с сайтов издательств, PubMed и репозиториев | Основной |
| OpenAlex PDF Finder | Прикрепление unpaywall PDF открытого доступа к уже существующим записям через OpenAlex (в дополнение к нативному способу скачивания pdf) | Основной |
| Zotero Scihub (`feature/annas-archive-provider`) | Пакетная загрузка PDF для записей с DOI. В этой ветке рядом со Sci-Hub есть Anna's Archive; в `master` этого выбора нет | Основной |
| llm-for-zotero + Codex CLI | Вопросы к PDF, сопоставление работ, извлечение методологии; вход через ChatGPT без отдельного API-ключа | Основной |
| Zotero Semantic Search | Локальный поиск по смыслу среди фрагментов PDF, похожие документы, MCP | Основной |
| Z-Search | Поиск сразу в нескольких источниках и пакетный импорт | Основной |

## Схема работы

```text
Эталонные статьи в коллекции Zotero
        ↓
Inciteful
        ↓
Связанные публикации
        ↓
Пакетный импорт BibTeX в Zotero
        ↓
Z-Search
        ↓
OpenAlex PDF Finder
        ↓
Zotero Scihub
        ↓
Semantic Search / llm-for-zotero + Codex
        ↓
Анализ полных текстов
```

## Содержание

0. [Установка Zotero](#ru-0)
1. [Inciteful — поиск по корпусу эталонных статей](#ru-1)
2. [Получение полных текстов PDF](#ru-2)
3. [OpenAlex PDF Finder](#ru-3)
4. [Zotero Scihub](#ru-4)
5. [llm-for-zotero + Codex — работа с текстами PDF без отдельного API-ключа](#ru-5)
6. [Zotero Semantic Search — локальный семантический поиск по PDF](#ru-6)
7. [Z-Search](#ru-7)
8. [Безопасность публичного репозитория](#ru-8)
9. [Источники и документация](#ru-9)

<a id="ru-0"></a>

## 0. Установка Zotero

1. Установите [Zotero](https://www.zotero.org/download/) и [Zotero Connector](https://www.zotero.org/download/connectors).

Как установить `.xpi`-плагин: скачайте файл со страницы Releases соответствующего проекта → Zotero → Tools → Plugins → значок шестерёнки → Install Plugin From File → выберите `.xpi`. Не скачивайте случайные XPI со сторонних зеркал.

<a id="ru-1"></a>

## 1. Inciteful — поиск по корпусу эталонных статей

- Проект: https://github.com/inciteful-xyz/inciteful-zotero-plugin
- Релизы: https://github.com/inciteful-xyz/inciteful-zotero-plugin/releases
- Сервис: https://inciteful.xyz/

### Шаги

1. Установите сборку Inciteful, совместимую с вашей версией Zotero.
2. Добавьте 5–20 наиболее подходящих публикаций в папку, например `00_wheat`.
3. Щёлкните правой кнопкой мыши по коллекции и выберите **Graph Search using Inciteful.xyz**. Альтернатива: выделите несколько записей → **Inciteful Tools** → **Graph Search**.
4. Изучайте связанные статьи, общие цитирования и исследовательские кластеры **Inciteful Tools** → **Connect Papers**.
5. Экспортируйте подходящую подборку из веб-интерфейса в BibTeX и импортируйте файл в Zotero, предварительно выбрав целевую коллекцию.
6. Отбирайте публикации вручную или через LLM по конкретным критериям. Сходство по цитированию не подтверждает совпадение экспериментального дизайна.

<a id="ru-2"></a>

## 2. Получение полных текстов PDF

Официальная справка Zotero о вложениях и поиске PDF: https://www.zotero.org/support/attaching_files

Поиск остальных записей, которые не смог депонировать Zotero, описан в [OpenAlex PDF Finder](#ru-3) и в [Zotero Scihub](#ru-4).

<a id="ru-3"></a>

## 3. OpenAlex PDF Finder

- Проект: https://github.com/Littview/zotero-openalex-pdf
- Релизы: https://github.com/Littview/zotero-openalex-pdf/releases
- Имя плагина в манифесте: **Zotero OpenAlex PDF Finder**

Плагин ищет выбранные записи в [OpenAlex](https://openalex.org/), находит копию из открытого доступа (издатель, PubMed Central, arXiv или институциональный репозиторий) и прикрепляет PDF к этой записи. Для скачивания статей нужен API-ключ. Обзор на 1000 ссылок делает около 20 запросов, а бесплатный лимит — около 1000 запросов в день. 

<a id="ru-4"></a>

## 4. Zotero Scihub

- Нужная ветка: https://github.com/ethanwillis/zotero-scihub/tree/feature/annas-archive-provider
- Репозиторий: https://github.com/ethanwillis/zotero-scihub
- Релизы: https://github.com/ethanwillis/zotero-scihub/releases

В `master` нет выбора источника PDF, по умолчанию доступен только sci-hub. Коммит [`a88cac8`](https://github.com/ethanwillis/zotero-scihub/commit/a88cac8b0e0b5a7bc6110325a66fd36de77aced0).

### Компилляция плагина

1. Откройте **Help → About Zotero**. Ставьте плагин, только если версия входит в диапазон 7–10, заявленный этой веткой.
2. Установите Node.js 22.x: README ветки указывает эту версию как совпадающую с CI.
3. Соберите эту ветку:

   ```bash
   git clone --branch feature/annas-archive-provider https://github.com/ethanwillis/zotero-scihub.git
   cd zotero-scihub
   npm ci
   npm test
   npm run build
   ```

4. Сгенерируется `build/zotero-scihub-<version>.xpi`. Импортируйте его в Zotero.
5. Откройте **Edit → Settings** и панель **Zotero Scihub**. Оставьте **PDF source** на **Sci-Hub**, если не собираетесь выбирать **Anna's Archive**. Если во время большого импорта BibTeX загрузки не нужны, сначала выключите **Automatic PDF Download**.

<a id="ru-5"></a>

## 5. llm-for-zotero + Codex — вопросы к PDF без отдельного API-ключа

- Плагин: https://github.com/yilewang/llm-for-zotero
- Релизы: https://github.com/yilewang/llm-for-zotero/releases
- Codex CLI: https://github.com/openai/codex
- Справка по авторизации: https://learn.chatgpt.com/docs/cli/reference

### Рекомендуемый путь: Codex App Server

1. Убедитесь, что установлены Node.js и npm.
2. Установите Codex:

   ```bash
   npm install -g @openai/codex
   ```

3. Войдите через браузер с учётной записью ChatGPT:

   ```bash
   codex login
   codex login status
   ```

4. Установите последний релиз llm-for-zotero, совместимый с вашей версией Zotero.
5. В Zotero откройте **Preferences / Settings → llm-for-zotero → Agent**.
6. Включите **Enable Codex App Server integration**, выберите модель и уровень рассуждений.
7. Откройте PDF и проверьте запрос: `Summarize the experimental design and quote the passages supporting sample size, locations, and statistical models.`

Codex App Server — это связь плагина с Codex CLI, установленным на этом компьютере. Его не нужно путать с локальным MCP-сервером Semantic Search из [раздела 6](#ru-6).

Отдельный секретный ключ для этого пути импортировать не нужно. `codex login` сам сохраняет учётные данные в `~/.codex/auth.json`. Не копируйте этот файл в репозиторий, в `.env` проекта или на публичный сервер. Не выводите его через `cat`, `jq`, логи или скриншоты. На другом компьютере войдите заново.

Проверка окружения — [scripts/check-codex.sh](scripts/check-codex.sh):

```bash
bash scripts/check-codex.sh
```

Если графического браузера нет, смотрите `codex login --device-auth` в документации CLI.

### Примеры запросов

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

<a id="ru-6"></a>

## 6. Zotero Semantic Search — локальный семантический поиск по PDF

- Проект: https://github.com/ilDon/zotero-semantic-search
- Релизы: https://github.com/ilDon/zotero-semantic-search/releases/latest

1. Установите `.xpi` со страницы Releases.
2. Откройте **Tools → Semantic Search** (в Linux — Ctrl+Shift+E, если сочетание свободно).
3. Скачайте предложенную модель эмбеддингов и дождитесь индексации PDF.
4. Ищите целыми фразами, например: `Genotype was treated as a random effect and year as a fixed effect in a mixed model.`
5. Переходите к найденным страницам PDF. Используйте **Find Similar Documents** и сохранение результатов поиска в коллекцию.

### Опционально: подключить MCP к агенту

В настройках Semantic Search включите локальный MCP-сервер. Документированный адрес:

```text
http://127.0.0.1:23119/semantic-search/mcp
```

Если MCP-клиент поддерживает Streamable HTTP, подключите его к этому URL. Для Codex CLI, когда сам Codex должен искать по проиндексированной библиотеке:

```bash
codex mcp add zotero-semantic --url http://127.0.0.1:23119/semantic-search/mcp
codex mcp list
```

Может пригодиться для интеграции API ChatGpt, Deepseek и т.д.

<a id="ru-7"></a>

## 7. Z-Search

- Проект: https://github.com/Liozhang/z-search
- Релизы: https://github.com/Liozhang/z-search/releases

Плагин ищет в OpenAlex, Semantic Scholar, PubMed, Europe PMC и других источниках, отображает уровень журнала, Impact Factor, умеет импортировать результаты и прикреплять PDF.

<a id="ru-8"></a>

## 8. Безопасность публичного репозитория

- Не коммитьте `~/.codex/auth.json`, файлы `*.env` с реальными значениями, токены, cookies, дампы Zotero, закрытые PDF, приватные пути и IP-адреса.
- Не копируйте каталог `~/.codex` и профиль Zotero в репозиторий.
- Входите через `codex login`, а не переносом токена вручную. На удалённой машине авторизуйтесь там же, штатным входом Codex.
- Не публикуйте скриншоты настроек, если на них видны идентификаторы аккаунтов или ключи.
- Не коммитьте API-ключи OpenAlex, адреса Sci-Hub или Anna's Archive, cookies и настройки частных прокси.
- Перед публикацией просмотрите содержимое файлов и историю Git. `.gitignore` не стирает секрет, который уже попал в историю. Такой токен нужно сразу отозвать и выпустить заново.

Шаблон исключений — [`.gitignore`](.gitignore). [scripts/check-codex.sh](scripts/check-codex.sh) не печатает содержимое auth-файлов.

<a id="ru-9"></a>

## 9. Источники и документация

- [Загрузка Zotero](https://www.zotero.org/download/) и [документация Zotero](https://www.zotero.org/support/)
- [Zotero Connector](https://www.zotero.org/download/connectors)
- [Вложения и поиск PDF](https://www.zotero.org/support/attaching_files)
- [Пользовательские PDF-резолверы Zotero](https://www.zotero.org/support/kb/custom_pdf_resolvers)
- [Плагин Inciteful для Zotero](https://github.com/inciteful-xyz/inciteful-zotero-plugin) · [релизы](https://github.com/inciteful-xyz/inciteful-zotero-plugin/releases) · [inciteful.xyz](https://inciteful.xyz/)
- [OpenAlex PDF Finder](https://github.com/Littview/zotero-openalex-pdf) · [релизы](https://github.com/Littview/zotero-openalex-pdf/releases) · [OpenAlex](https://openalex.org/)
- [Zotero Scihub, ветка `feature/annas-archive-provider`](https://github.com/ethanwillis/zotero-scihub/tree/feature/annas-archive-provider) · [репозиторий](https://github.com/ethanwillis/zotero-scihub) · [релизы](https://github.com/ethanwillis/zotero-scihub/releases)
- [llm-for-zotero](https://github.com/yilewang/llm-for-zotero) · [релизы](https://github.com/yilewang/llm-for-zotero/releases)
- [Codex CLI](https://github.com/openai/codex)
- [Codex CLI: вход и MCP](https://learn.chatgpt.com/docs/cli/reference)
- [Zotero Semantic Search](https://github.com/ilDon/zotero-semantic-search) · [последний релиз](https://github.com/ilDon/zotero-semantic-search/releases/latest)
- [Z-Search](https://github.com/Liozhang/z-search) · [релизы](https://github.com/Liozhang/z-search/releases)
- [PubMed Central](https://www.ncbi.nlm.nih.gov/pmc/)
- [Europe PMC](https://europepmc.org/)

## Лицензия

Текст гайда можно распространять по [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Права на сторонние плагины, PDF и изображения принадлежат их авторам.
