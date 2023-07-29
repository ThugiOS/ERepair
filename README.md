<img src="https://img.shields.io/badge/Swift-UIKit-success">
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/logo.png" width="220">
</p>

---

## За основу была взята идея создания приложения для бизнеса по ремонту и обслуживанию электросамокатов и другого электротранспорта. 
### Данный проект представлен как демо и уже ведется разработка приложения для релиза в App Store.

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
- Реализована валидация всех символов, введенных в поле ввода имени/почты/пароля, до отправки на сервер.
- Если пользователь не зарегестрирован или некорректно ввел данные, то он получит соответствующее сообщение. Сообщение реализовано через `UIAlertController`
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/auth.gif" width="220">  <img src="https://github.com/catthug92/ERepair/blob/main/gif/errorLogin.gif" width="220">
</p>

# Основной экран
### Основной экран включает в себя `UITabBar` с 3 вкладками: "Главная", "Цены", "Мы на карте"

## "Главная"
### На этой вкладке реализовано:
- `UILabel` с приветсвенным сообщением и именем пользователя.
- Автоматически сгенерированный QR-код, с помощью `CoreImage`, в котором содержится уникальный UID пользователя и хранящийся в Cloud Firestore.
- Кнопка перехода в чат с мастером.
- Кнопка звонка мастеру `UIApplication.shared.open(URL(string: "number_phone"))`
- Кнопки удобного перехода в мессенджеры Viber и Telegram `UIApplication.shared.open(URL(string: "Viber|Telegram"))`
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/main.gif" width="220">
</p>


## Чат с мастером
### На этом экране реализовано:
- `Firebase Realtime Database` в которой хранятся все сообщения.
- `UICollectionView` в котором находится список входящих сообщений от мастера.
- Возможность отправки сообщения мастеру.
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/chat.gif" width="220">
</p>


## "Услуги"
### На этой вкладке реализовано:
- `UICollectionView` со слайдами цен и прочих услуг
- `UIPageControl` для удобства навигации между слайдами 
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/catalog.gif" width="220">
</p>


## "Карта"
### На этой вкладке реализовано:
- Подключение Apple Maps с помощью фреймворка `MapKit`
- Системный "Pin" с местонахождением мастерской и краткой информацией.
- Кнопка предоставляющая дополнительную информацию о мастерской: фото мастерской, адрес и режим работы.
- Кнопка быстрого перехода к местоположению пользователя с помощью фреймворка `CoreLocation`
- Кнопка быстрого перехода к местоположению мастерской.
<p align="center">
      <img src="https://github.com/catthug92/ERepair/blob/main/gif/map.gif" width="220"> 
</p>


### Связь
[LinkedIn](https://www.linkedin.com/in/artem-swift/) | [Email](mailto:artem.ios.nikitin@gmail.com "artem.ios.nikitin@gmail.com")
