# devops-netology
my first line

Значит тут такое.
В локальной папке .terraform буду игнорироваться следующие объекты:

*.tfstate - все файлы с расширением TFSTATE

*.tfstate.* - все файлы TFSTATE с любым доп. расширением

crash.log - конкретно файл crash.log (лог ошибок и "вылетов")


*.tfvars - все файлы с расширением TFVARS, судя по всему файлы содержащие конфиденциальную информацию как пароли, ключи и т.д

override.tf - конкретно этот файл 
override.tf.json - конкретно этот файл
*_override.tf 
*_override.tf.json - все типы файлов TF и TF.JSON начинающихся с любого слова и заканчивающиеся на _override

Четыре строки сверу - это файлы использующиеся для локального переопределения ресурсов (что-бы это не значило)

#!example_override.tf - исключить из проверки выше на игнор файл example_override.tf, но это строка в закрыта клеткой (коммент)

# example: *tfplan* - тут не совсем понятно, но вроде шаблон для исключения файлов типа TFPLAN или файлов example:(вставь что хочу)tfplan(вставь что хочу)

.terraformrc - игнорировать файл конфигурации .terraformrc
terraform.rc - игнорировать файл конфигурации terraform.rc



Домашнее задание к занятию «2.4. Инструменты Git»

Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea ?
Вводим команду git show aefea и получаем результат:

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545

комментарий - Update CHANGELOG.md

2)	Какому тегу соответствует коммит 85024d3?
Аналогично вводим команду git show 85024d3 и получаем результат:

tag: v0.12.23

3)	Сколько родителей у коммита b8d720? Напишите их хеши?
Вводим команду git show --no-patch –format=%P b8d720 и получаем результат:

1 предок -56cd7859e05c36c06b56d013b55a252d0bb7e158   
2 предок- 9ea88f22fc6269854151c571162c5bcf958bee2b

4)	Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24
Вводим команду git log v0.12.23..v0.12.24 --oneline -s и получаем результат:
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release

5)	Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточия 
перечислены аргументы)
Вводим команду 
git log -S 'func providerSource' –-oneline
Получаем 2 коммита
5af1e6234 main: Honor explicit provider_installation CLI config when present
8c928e835 main: Consult local directories as potential mirrors of providers
Вводим команду 
git log -S 'func providerSource' –-p

Читаем где была создана, а где изменена функция 
func providerSource
func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
+       if len(configs) == 0 {
+               // If there's no explicit installation configuration then we'll build
+               // up an implicit one with direct registry installation along with
+               // some automatically-selected local filesystem mirrors.
+               return implicitProviderSource(services), nil

Это коммит - 5af1e6234

6)	Найдите все коммиты в которых была изменена функция globalPluginDirs
Если расширенный ответ, с указанием мест где было изменено то

git log -S "globalPluginDirs" –p

Если краткий ответ, то
git log -S "globalPluginDirs" --oneline
35a058fb3 main: configure credentials from the CLI config file
c0b176109 prevent log output during init
8364383c3 Push plugin discovery down into command package

7)	Кто автор функции synchronizedWriters?

Чтож, пытался как-то выйти на автора через Git blame и git grep, но ничего не получилось. Если подскажете буду рад.
Использовал команду
$ git log -S 'synchronizedWriters' –oneline
bdfea50cc remove unused
fd4f7eb0b remove prefixed io
5ac311e2a main: synchronize writes to VT100-faker on Windows
Нашел все комиты где упоминалась данная функция, затем через git show просмотрел авторов. Автор функции - Martin Atkins <mart@degeneration.co.uk>
