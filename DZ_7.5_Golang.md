
# Домашнее задание к занятию "9.1. Введение в Golang"



## Задача 1. Установите golang

​	![Screenshot_1](C:\Users\KING\Desktop\Screenshot_1.jpg)



## Задача 2. Знакомство с gotour



## Задача 3. Написание кода

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию `Scanf`:

```
package main

import "fmt"

func MtoF(m float64)(f float64) {
    f = m * 3.281
    return
}

func main() {
    fmt.Print("Введите длину в метрах (для перевода в футы): ")
    var input float64
    fmt.Scanf("%f", &input)

    output := MtoF(input)

    fmt.Printf("В метрах %v, а в футах это %v\n", input, output)
}
```

2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```
package main

import "fmt"
import "sort"

func GetMin (toSort []int)(minNum int) {
	sort.Ints(toSort)
	minNum = toSort[0]
	return
}

func main() {
	x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
	y := GetMin(x)
	fmt.Printf("Наименьший элемент в списке: %v\n", y)
```

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

```
package main

import "fmt"

func FilterList ()(devidedWithNoReminder []int) {
	for i := 1;  i <= 100; i ++ {
		if	i % 3 == 0 { 
			devidedWithNoReminder = append(devidedWithNoReminder, i)
		}
	}	
	return
}

func main() {
	toPrint := FilterList()
	fmt.Printf("Числа от 1 до 100, которые делятся на 3 без остатка: %v\n", toPrint)
}
```
