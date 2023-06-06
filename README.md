
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/logo.png" width="220">
</p>

---
### Данный пет-проект является курсовым в рамках обучения в школе [TeachMeSkills](https://teachmeskills.by) "iOS разработчик".

За основу была взята идея создания приложения для существуещего бизнеса по ремонту и обслуживанию электросамокатов и другого электротранспорта.
Приложение включает в себя:
- Регистрацию
- Автоматически сгенерированный QR-Код для системы лояльности и внутреннего учета
- Внутренний чат с мастером
- Телефон и ссылки на другие мессенджеры
- Актуальные цены на ремент и прочие услуги
- Карту с местонахождением мастерской для удобства пользователя 
 
---


## Stack
- UIKit
- CoreImage
- CoreLocation 
- MapKit
- NSLayoutConstraint
- Firebase Authentication
- Firebase Cloud Firestore
- Firebase Realtime Database
- Firebase Crashlytics

# Аутентификация
### Регистрация пользователя реализована через Firebase Authentication/Cloud Firestore, восстановление пароля происходит классическим способом через email.
- Реализована валидация всех символов введеных в поле ввода имени/почты/пароля до отправки на сервер
- При отсутствии пользователя или некорректном вводе пользователь получит соответсвующее сообщение. Которое реализовано через `UIAlertController`  
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/auth.gif" width="180">  <img src="https://github.com/catthug92/ERepair/blob/main/gif/errorLogin.gif" width="180">
</p>

# Основной экран
### Основной экран включает всебя `UITabBar` с 3 вкладками "Главная", "Цены", "Мы на карте"

## "Главная"
### На этой вкладке реализовано:
- UILabel с приветсвенным сообщением и именем пользователя.
- Автоматически сгенерированный QR-код, с помощью `CoreImage`. В котором содержится уникальный UID пользователя и хранящийся в Cloud Firestore.
- Кнопка перехода в чат с мастером
- Кнопка звонка мастеру `UIApplication.shared.open(URL(string: "number_phone"))`
- Кнопка удобного перехода в мессенджеры Viber и Telegram `UIApplication.shared.open(URL(string: "Viber|Telegram"))`

<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/main.gif" width="180">
</p>


## Чат с мастером
### На этом экране реализовано:
- `Firebase Realtime Database` в которой хранятся все сообщения
- `UICollectionView` в котором находится список входящих сообщений от мастера
- Возможность отправки сообщения мастеру


<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/chat.gif" width="180">
</p>


## "Услуги"
### На этой вкладке реализовано:
- `UICollectionView` со слайдами цен и прочих услуг
- `UIPageControl` для удобства навигации между слайдами 
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/catalog.gif" width="180">
</p>


## "Карта"
### На этой вкладке реализовано:
- Подключение Apple Maps с помощью фреймворка `MapKit`
- Системный "Pin" с местонахождением мастерской и краткой информации.
- Кнопка демонстрации фото входа в мастерскую, точным адресом и режимом работы
- Кнопка быстрого перехода к местоположению пользователя с помощью фреймворка `CoreLocation`
- Кнопка быстрого перехода к местоположению мастерской
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/map.gif" width="180"> 
</p>


## Связь

[LinkedIn](https://www.linkedin.com/in/artem-swift/)
