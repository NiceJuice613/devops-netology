
# Домашнее задание к занятию "9.1. Жизненный цикл разработки ПО"

## Задача.
​	В рамках основной части необходимо создать собственные  workflow для двух типов задач: bug и остальные типы задач. Задачи типа  bug должны проходить следующий жизненный цикл:

1. Open -> On reproduce
2. On reproduce <-> Open, Done reproduce
3. Done reproduce -> On fix
4. On fix <-> On reproduce, Done fix
5. Done fix -> On test
6. On test <-> On fix, Done
7. Done <-> Closed, Open
8. ![Screenshot_1](C:\Users\KING\Desktop\Screenshot_1.jpg)

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop

2. On develop <-> Open, Done develop

3. Done develop -> On test

4. On test <-> On develop, Done

5. Done <-> Closed, Open

   ![Screenshot_2](C:\Users\KING\Desktop\Screenshot_2.jpg)

Создать задачу с типом bug, попытаться провести его по  всему workflow до Done. Создать задачу с типом epic, к ней привязать  несколько задач с типом task, провести их по всему workflow до Done. При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open. Перейти в scrum, запланировать новый спринт, состоящий из задач эпика и  одного бага, стартовать спринт, провести задачи до состояния Closed.  Закрыть спринт.

![Screenshot_3](C:\Users\KING\Desktop\Screenshot_3.jpg)

![Screenshot_4](C:\Users\KING\Desktop\Screenshot_4.jpg)

![Screenshot_5](C:\Users\KING\Desktop\Screenshot_5.jpg)

![Screenshot_6](C:\Users\KING\Desktop\Screenshot_6.jpg)

К сожалению на сайте Jira не нашел где выгружать схемы Workflow в xml
