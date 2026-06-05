import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';
import type * as OpenApiPlugin from 'docusaurus-plugin-openapi-docs';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
  title: 'RoadFX 文档',
  tagline: '开源智能客服系统文档（多智能体 · 知识库 · MCP 工具 · 多渠道接入）',
  favicon: 'img/logo.svg',

  // Future flags, see https://docusaurus.io/docs/api/docusaurus-config#future
  future: {
    v4: true, // Improve compatibility with the upcoming Docusaurus v4
  },

  // 生产环境站点 URL（建议按实际 GitHub Pages 配置修改）
  // 例如：托管在 https://ivansslo.github.io/roadfx/ 时：
  // url: 'https://ivansslo.github.io',
  // baseUrl: '/roadfx/',
  url: 'https://roadfx.ai',
  baseUrl: '/',

  // GitHub Pages 部署相关配置（请按实际仓库替换）
  organizationName: 'ivansslo', // GitHub org/user
  projectName: 'roadfx', // 仓库名

  onBrokenLinks: 'throw',

  scripts: [
    {
      src: 'https://widget.roadfx-ai.com/roadfx-widget-sdk.js?api_key=ak_live_qIMhQRx5klxuRHZkDke9HqZC3wi9sB43',
      async: true,
    },
  ],

  // 多语言支持
  i18n: {
    defaultLocale: 'zh-Hans',
    locales: ['zh-Hans', 'en'],
    localeConfigs: {
      'zh-Hans': {
        label: '简体中文',
        htmlLang: 'zh-Hans',
      },
      en: {
        label: 'English',
        htmlLang: 'en',
      },
    },
  },

  plugins: [
    [
      'docusaurus-plugin-openapi-docs',
      {
        id: 'api',
        docsPluginId: 'classic',
        config: {
          roadfxApi: {
            specPath: 'api-specs/openapi.yaml',
            outputDir: 'docs/api',
            sidebarOptions: {
              groupPathsBy: 'tag',
              categoryLinkSource: 'tag',
            },
          },
        } satisfies OpenApiPlugin.Options,
      },
    ],
  ],

  themes: ['docusaurus-theme-openapi-docs', '@docusaurus/theme-mermaid'],

  markdown: {
    mermaid: true,
  },

  presets: [
    [
      'classic',
      {
        docs: {
          // 使用 docs-site/docs 作为文档目录
          path: 'docs',
          routeBasePath: '/', // 文档挂在站点根路径
          sidebarPath: './sidebars.ts',
          // 根据实际仓库调整，当前示例指向 roadfx 主仓库
          editUrl: 'https://github.com/ivansslo/roadfx/edit/main/docs-site/',
          // 启用 OpenAPI 文档处理
          docItemComponent: '@theme/ApiItem',
        },
        // 目前只用文档，不启用博客
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: 'img/docusaurus-social-card.jpg',
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'roadfx',
      logo: {
        alt: 'roadfx Logo',
        src: 'img/logo.svg',
      },
      hideOnScroll: true,
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'docsSidebar',
          position: 'left',
          label: '指南',
        },
        {
          type: 'docSidebar',
          sidebarId: 'pluginSidebar',
          position: 'left',
          label: '插件开发',
        },
        // {
        //   type: 'docSidebar',
        //   sidebarId: 'apiSidebar',
        //   position: 'left',
        //   label: 'API',
        // },
        {
          type: 'localeDropdown',
          position: 'right',
        },
        {
          href: 'https://github.com/ivansslo/roadfx',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'light',
      links: [],
      copyright: `Copyright © ${new Date().getFullYear()} roadfx.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
