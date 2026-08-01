# 📝 Advanced Flutter Todo App

A highly performant, feature-rich, and beautifully designed Todo application built with Flutter. This project goes beyond basic task management by introducing advanced features like drag-and-drop reordering, task pinning, dynamic statistics, and seamless responsive design across all devices.

## 📸 Screenshots

### Light Mode & Dark Mode

<p align="center">
  <img src="https://github.com/user-attachments/assets/29b7ef85-2953-4afe-b2be-9adfc282193d" width="48%" alt="Light Mode - Tasks Screen"/>
  &nbsp;
  <img src="https://github.com/user-attachments/assets/3d8ea58c-09b6-4023-910b-622ed5b100fb" width="48%" alt="Dark Mode - Tasks Screen"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/773dc682-8509-4775-adcf-1ea3dc05423a"  width="48%" alt="Light Mode - Task Addition"/>
  &nbsp;
  <img src="https://github.com/user-attachments/assets/840f1e3a-d235-400a-9e0f-4655753b9c74" width="48%" alt="Dark Mode - Task Addition"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ab12fa50-1dac-4506-9bf1-cfcd7a85783e" width="48%" alt="Light Mode - Search Screen"/>
  &nbsp;
  <img src="https://github.com/user-attachments/assets/0864aef7-1347-4dc3-ba2e-6fb6a1ee0df6" width="48%" alt="Dark Mode - Search Screen"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/f66dc5d2-8571-460a-98dc-1bb27adccb2b" width="48%" alt="Light Mode - Dashboard"/>
  &nbsp;
  <img src="https://github.com/user-attachments/assets/e83986d5-f914-406e-ae8c-c706b09dce72" width="48%" alt="Dark Mode - Dashboard"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/46620655-c7c9-4c40-b160-7befa4755d94" width="48%" alt="Light Mode - Settings"/>
  &nbsp;
  <img src="https://github.com/user-attachments/assets/4df37136-da93-43ea-b505-4acca58c256b" width="48%" alt="Dark Mode - Settings"/>
</p>


## ✨ Key Features

* **State Management (`Provider`):** Utilizes `ChangeNotifierProvider` and extensions (`context.watch` / `context.read`) to ensure precise, minimal widget rebuilds. 
* **Advanced Drag & Drop (Reorderable):** Seamlessly reorder tasks using a custom `ReorderableListView`. Built with index-safe logic that handles dynamic list updates and pinned-task constraints without crashing.
* **Task Pinning (Pin to Top):** Prioritize important tasks by pinning them to the top of the list. Pinned tasks automatically maintain their hierarchy above unpinned items.
* **Dynamic Statistics Dashboard (`StatsScreen`):** A real-time analytics screen that calculates total tasks, remaining tasks, completed tasks, and overall completion percentages globally—ignoring active UI filters for accurate data representation.
* **Responsive UI & Typography:** Built utilizing `flutter_screenutil` to guarantee pixel-perfect UI, adaptable font sizes, and consistent padding/margins across varying screen sizes and devices.
* **Beautiful Theming & UI Elements:** 
  * Fully supports switching between **Light** and **Dark** modes on the fly using a dedicated `ThemeProvider`.
  * Customized dynamic components, like a custom Floating Action Button (FAB) with gradient backgrounds and adaptive shadows tailored for each theme.
  * Interactive Bottom Sheets (`TaskAdditionModal`) for quick and elegant task entry.
* **Smart Filtering & Categories:** Filter tasks effortlessly by status (Active/Done) or custom categories (Work/Personal/Shopping/Study).
* **Clean Architecture:** The codebase follows a strict and scalable folder structure, neatly separating models, services, providers, constants (`AppThemes`), and UI components for maximum maintainability.

## 🛠️ Tech Stack
* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Local Storage:** Used for instantaneous local data persistence (`_saveAndNotify` operations).
