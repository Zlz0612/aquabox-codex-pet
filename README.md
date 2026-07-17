# 华世未来 Codex Pet

一只从青绿色机箱中探出身子的开朗 Q 版少女桌宠。

## 推荐安装方式（不依赖弹窗）

`codex://` 安装窗口没有出现时，可以直接安装到本地宠物目录。

Windows PowerShell：

```powershell
irm https://raw.githubusercontent.com/Zlz0612/aquabox-codex-pet/main/install.ps1 | iex
```

macOS / Linux：

```bash
curl -fsSL https://raw.githubusercontent.com/Zlz0612/aquabox-codex-pet/main/install.sh | sh
```

安装后完全退出并重新打开 Codex，然后进入 **Settings > Pets**，点击 **Refresh** 并选择“华世未来”。执行远程脚本前可以先在仓库中查看脚本内容。

## Codex 深链接安装

支持宠物安装深链接的 Codex 版本也可以打开：

```text
codex://pets/install?name=%E5%8D%8E%E4%B8%96%E6%9C%AA%E6%9D%A5&imageUrl=https%3A%2F%2Fraw.githubusercontent.com%2FZlz0612%2Faquabox-codex-pet%2Fmain%2Fspritesheet.webp&spriteVersionNumber=2
```

## 手动安装

将 `pet.json` 和 `spritesheet.webp` 下载到：

```text
~/.codex/pets/aquabox/
```

完全退出并重新打开 Codex，然后在 **Settings > Pets** 中刷新并选择“华世未来”。

## 格式

- Codex Pet sprite version: `2`
- 图集尺寸：`1536 × 2288`
- 单元格尺寸：`192 × 208`
- 透明 WebP
