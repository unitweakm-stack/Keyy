# 🛡️ Backeer Key System Loader

Ushbu loyiha iOS dylib fayllari uchun 5 kunlik va bir marta ishlatiladigan kalitlarni tekshirish tizimidir.

## 📂 Loyiha tarkibi:
*   **`Tweak.m`**: 150 ta kalit va `@backeer` Telegram akkuntini o'z ichiga olgan asosiy loader kodi.
*   **`Makefile`**: Theos orqali kompyutsiya qilish (compile) uchun sozlamalar.
*   **`keys.txt`**: 150 ta noyob kalitlar ro'yxati.

## 🚀 Qanday qilib dylib qilinadi (How to Compile):
1.  Ushbu fayllarni Theos loyihasiga yuklang.
2.  `make` buyrug'ini bering.
3.  Tayyor bo'lgan `BackeerLoader.dylib` faylini oling.

## 🛠️ Qanday ishlatiladi:
1.  `BackeerLoader.dylib` va asosiy `App(2).dylib` fayllarini `/Library/MobileSubstrate/DynamicLibraries/` manziliga joylang.
2.  `BackeerLoader.plist` fayliga o'yinning Bundle ID'sini yozing.
3.  O'yinni ochganda kalit so'raydi, `keys.txt` dagi kalitni kiriting.

---
**Sotib olish uchun (For Purchase):** [@backeer](https://t.me/backeer)
