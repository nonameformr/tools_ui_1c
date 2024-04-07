

#Область ПрограммныйИнтерфейс

// Новый данные библиотеки редактора.
// 
// Возвращаемое значение:
//  Структура -  Новый данные библиотеки редактора:
//  	* Скрипты - Массив из Строка - Массив адресов файлов библиотеки во временном хранилище
//  	* Стили - Массив из Строка- Массив адресов файлов библиотеки во временном хранилище
Функция НовыйДанныеБиблиотекиРедактора() Экспорт
	ДанныеБиблиотеки = Новый Структура;
	ДанныеБиблиотеки.Вставить("Скрипты", Новый Массив);
	ДанныеБиблиотеки.Вставить("Стили", Новый Массив);
	
	Возврат ДанныеБиблиотеки;
КонецФункции

// Имя подключаемой обработки для исполнения кода редактора.
// 
// Параметры:
//  Идентификатор -Строка- Идентификатор
// 
// Возвращаемое значение:
//  Строка
Функция ИмяПодключаемойОбработкиДляИсполненияКодаРедактора(Идентификатор) Экспорт
	Возврат "УИ_РедакторКода_ОбработкаИсполнения_"+Идентификатор;
КонецФункции

Функция ПрефиксЭлементовРедактораКода() Экспорт
	Возврат "РедакторКода1С";
КонецФункции

Функция ИмяРеквизитаРедактораКода(ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_"+ИдентификаторРедактора;
КонецФункции

Функция ИмяРеквизитаРедактораКодаВидРедактора() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_ВидРедактора";
КонецФункции

// Имя реквизита редактора кода библиотеки редакторов.
// 
// Возвращаемое значение:
//  Строка -  Имя реквизита редактора кода библиотеки редакторов
Функция ИмяРеквизитаРедактораКодаДанныеБиблиотекРедакторов() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_ДанныеБиблиотекРедакторов";
КонецФункции

Функция ИмяРеквизитаРедактораКодаСписокРедакторовФормы() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_СписокРедакторовФормы";
КонецФункции

// Имя реквизита редактора кода первичная инициализация прошла.
// 
// Возвращаемое значение:
// Строка 
Функция ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_ПервичнаяИнициализацияПрошла";
КонецФункции

Функция ИмяРеквизитаРедактораКодаРедакторыФормы(ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_РедакторыФормы";
КонецФункции

Функция ИмяКнопкиКоманднойПанели(ИмяКоманды, ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода() + "_" + ИмяКоманды + "_" + ИдентификаторРедактора;
КонецФункции

Функция ВариантыРедактораКода() Экспорт
	Варианты = Новый Структура;
	Варианты.Вставить("Текст", "Текст");
	Варианты.Вставить("Ace", "Ace");
	Варианты.Вставить("Monaco", "Monaco");

	Возврат Варианты;
КонецФункции

Функция ВариантРедактораПоУмолчанию() Экспорт
	Возврат ВариантыРедактораКода().Monaco;
КонецФункции

// Редактор кода использует поле HTML.
// 
// Параметры:
//  ВидРедактора -Строка- Вид редактора
// 
// Возвращаемое значение:
//  Булево -  Редактор кода использует поле HTML
Функция РедакторКодаИспользуетПолеHTML(ВидРедактора) Экспорт
	Варианты=ВариантыРедактораКода();
	Возврат ВидРедактора = Варианты.Ace
		Или ВидРедактора = Варианты.Monaco;
КонецФункции

// Первичная инициализация редакторов прошла.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
// 
// Возвращаемое значение:
//  Булево
Функция ПервичнаяИнициализацияРедакторовПрошла(Форма) Экспорт
	Возврат Форма[ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла()];
КонецФункции 

// Установить признак первичная инициализация редакторов прошла.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//  ИнициализацияПрошла - Булево
Процедура УстановитьПризнакПервичнаяИнициализацияРедакторовПрошла(Форма, ИнициализацияПрошла) Экспорт
	Форма[ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла()] = ИнициализацияПрошла;
КонецПроцедуры

Функция ИдентификаторРедактораПоЭлементуФормы(Форма, Элемент) Экспорт
	РедакторыФормы = Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы()];

	Для Каждого КлючЗначение Из РедакторыФормы Цикл
		Если КлючЗначение.Значение.ПолеРедактора = Элемент.Имя Тогда
			Возврат КлючЗначение.Ключ;
		КонецЕсли;
	КонецЦикла;

	Возврат Неопределено;
КонецФункции

Функция СтруктураИмениКомандыФормы(ИмяКоманды) Экспорт
	МассивИмени = СтрРазделить(ИмяКоманды, "_");

	СтруктураИмени = Новый Структура;
	СтруктураИмени.Вставить("ИмяКоманды", МассивИмени[1]);
	СтруктураИмени.Вставить("ИдентификаторРедактора", МассивИмени[2]);

	Возврат СтруктураИмени;
КонецФункции

Функция ВыполнитьАлгоритм(__ТекстАлготима__, __Контекст__, ИсполнениеНаКлиенте = Ложь, Форма = Неопределено,
	ИдентификаторРедактора = Неопределено) Экспорт
	УИ__Успешно__ = Истина;
	УИ__ОписаниеОшибки__ = "";
	УИ__НачалоВыполнения__ = ТекущаяУниверсальнаяДатаВМиллисекундах();

	Если ЗначениеЗаполнено(__ТекстАлготима__) Тогда
		ВыполнятьЧерезОбработку = Ложь;
		Если Форма <> Неопределено И ИдентификаторРедактора <> Неопределено Тогда
			РедакторыФормы = РедакторыФормы(Форма);
			ДанныеРедактора = РедакторыФормы[ИдентификаторРедактора];
			ВыполнятьЧерезОбработку = ДанныеРедактора.ИспользоватьОбработкуДляВыполненияКода;
		КонецЕсли;

		Если ВыполнятьЧерезОбработку Тогда
			Попытка
				Если ИсполнениеНаКлиенте Тогда
#Если НаКлиенте Тогда
					//@skip-check use-non-recommended-method
					ИсполнительОбработка = ПолучитьФорму("ВнешняяОбработка."
														 + ИмяПодключаемойОбработкиДляИсполненияКодаРедактора(ИдентификаторРедактора)
														 + ".Форма");
#КонецЕсли
				Иначе
#Если Не НаКлиенте Или ТолстыйКлиентОбычноеПриложение Или ТолстыйКлиентУправляемоеПриложение Тогда
					ИсполнительОбработка = ВнешниеОбработки.Создать(ИмяПодключаемойОбработкиДляИсполненияКодаРедактора(ИдентификаторРедактора));
#КонецЕсли
				КонецЕсли;
				ИсполнительОбработка.УИ_ИнициализироватьПеременные(__Контекст__);
				ИсполнительОбработка.УИ_ВыполнитьАлгоритм();

			Исключение
				УИ__Успешно__ = Ложь;
				УИ__ОписаниеОшибки__ = ОписаниеОшибки();
				Сообщить(УИ__ОписаниеОшибки__);
			КонецПопытки;
		Иначе
			ВыполняемыйТекстАлгоритма = ДополненныйКонтекстомКодАлгоритма(__ТекстАлготима__, __Контекст__);

			Попытка
				//@skip-check unsupported-operator
				Выполнить (ВыполняемыйТекстАлгоритма);
			Исключение
				УИ__Успешно__ = Ложь;
				УИ__ОписаниеОшибки__ = ОписаниеОшибки();
				Сообщить(УИ__ОписаниеОшибки__);
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;

	ОкончаниеВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();

	РезультатВыполнения = Новый Структура;
	РезультатВыполнения.Вставить("Успешно", УИ__Успешно__);
	РезультатВыполнения.Вставить("ВремяВыполнения", ОкончаниеВыполнения - УИ__НачалоВыполнения__);
	РезультатВыполнения.Вставить("ОписаниеОшибки", УИ__ОписаниеОшибки__);

	Возврат РезультатВыполнения;
КонецФункции

Функция ВидРедактораКодаФормы(Форма) Экспорт
	Возврат Форма[УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаВидРедактора()];
КонецФункции

// Новый кэш текстов редактора.
// 
// Возвращаемое значение:
//  Структура - Новый кэш текстов редактора:
// * Текст - Строка -
// * ОригинальныйТекст - Строка -
Функция НовыйКэшТекстовРедактора() Экспорт
	Структура = Новый Структура;
	Структура.Вставить("Текст", "");
	Структура.Вставить("ОригинальныйТекст", "");
	
	Возврат Структура;
КонецФункции

#Область ИменаКомандКоманднойПанели


// Имя команды режим выполнения через обработку.
// 
// Возвращаемое значение:
//  Строка -  Имя команды режим выполнения через обработку
Функция ИмяКомандыРежимВыполненияЧерезОбработку() Экспорт
	Возврат "РежимВыполненияЧерезОбработку";
КонецФункции

// Имя команды конструктор запроса.
// 
// Возвращаемое значение:
//  Строка -  Имя команды конструктор запроса
Функция ИмяКомандыКонструкторЗапроса() Экспорт
	Возврат "КонструкторЗапроса";
КонецФункции

// Имя команды поделиться алгоритмом.
// 
// Возвращаемое значение:
//  Строка -  Имя команды поделиться алгоритмом
Функция ИмяКомандыПоделитьсяАлгоритмом() Экспорт
	Возврат "ПоделитьсяАлгоритмом";
КонецФункции

// Имя команды загрузить алгоритм.
// 
// Возвращаемое значение:
//  Строка -  Имя команды загрузить алгоритм
Функция ИмяКомандыЗагрузитьАлгоритм() Экспорт
	Возврат "ЗагрузитьАлгоритм";
КонецФункции

// Имя команды начать сессию взаимодействия.
// 
// Возвращаемое значение:
//  Строка -  Имя команды начать сессию взаимодействия
Функция ИмяКомандыНачатьСессиюВзаимодействия() Экспорт
	Возврат "НачатьСессиюВзаимодействия";
КонецФункции

// Имя команды закончить сессию взаимодействия.
// 
// Возвращаемое значение:
//  Строка -  Имя команды закончить сессию взаимодействия
Функция ИмяКомандыЗакончитьСессиюВзаимодействия() Экспорт
	Возврат "ЗакончитьСессиюВзаимодействия";
КонецФункции


#КонецОбласти

// Имя библиотеки взаимодействия для данных формы.
// 
// Параметры:
//  ВидРедактора - Строка- Вид редактора
// 
// Возвращаемое значение:
//  Строка - Имя библиотеки взаимодействия для данных формы
Функция ИмяБиблиотекиВзаимодействияДляДанныхФормы(ВидРедактора) Экспорт
	Возврат "БиблиотекаВзаимодействия"+ВидРедактора;
КонецФункции

// Редакторы формы.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения-Форма
// 
// Возвращаемое значение:
//  Структура из КлючИЗначение:
//  	* Ключ - Строка - Идентификатор редактора
//  	* Значение - см. НовыйДанныеРедактораФормы
Функция РедакторыФормы(Форма) Экспорт
	Возврат Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы()];
КонецФункции

// Новый данные редактора формы.
// 
// Возвращаемое значение:
//  Структура - Новый данные редактора формы:
// * СобытияРедактора - см. НовыйПараметрыСобытийРедактора
// * Инициализирован - Булево -
// * Видимость - Булево -
// * ТолькоПросмотр - Булево -
// * КэшТекстаРедактора - см. УИ_РедакторКодаКлиентСервер.НовыйКэшТекстовРедактора
// * Язык - Строка -
// * ПолеРедактора - Строка -
// * ИмяРеквизита - Строка -
// * ИмяКоманднойПанелиРедактора - Строка -
// * Идентификатор - Строка -
// * ИспользоватьОбработкуДляВыполненияКода - Булево -
// * ПараметрыРедактора - см. ПараметрыРедактораКодаПоУмолчанию
// * КэшРезультатовПодключенияОбработкиИсполнения -  см. НовыйКэшРезультатовИсполненияЧерезОбработку 
// * ПараметрыСессииВзаимодействия - см. НовыйПараметрыСессииВзаимодействия
// * КнопкиКонтекстногоМенюРедактораИнициализированы - Булево
Функция НовыйДанныеРедактораФормы() Экспорт
	ДанныеРедактора = Новый Структура;
	ДанныеРедактора.Вставить("Идентификатор", "");
	ДанныеРедактора.Вставить("СобытияРедактора", Неопределено);
	ДанныеРедактора.Вставить("Инициализирован", Ложь);
	ДанныеРедактора.Вставить("Видимость", Истина);
	ДанныеРедактора.Вставить("ТолькоПросмотр", Ложь);
	ДанныеРедактора.Вставить("КэшТекстаРедактора", Неопределено);
	ДанныеРедактора.Вставить("Язык", "bsl");
	ДанныеРедактора.Вставить("ПолеРедактора", "");
	ДанныеРедактора.Вставить("ИмяКоманднойПанелиРедактора", "");
	ДанныеРедактора.Вставить("ИмяРеквизита", "");
	ДанныеРедактора.Вставить("ИспользоватьОбработкуДляВыполненияКода", Ложь);
	ДанныеРедактора.Вставить("ПараметрыРедактора", Неопределено);
	ДанныеРедактора.Вставить("КэшРезультатовПодключенияОбработкиИсполнения", Неопределено);
	ДанныеРедактора.Вставить("ПараметрыСессииВзаимодействия", Неопределено);
	ДанныеРедактора.Вставить("КнопкиКонтекстногоМенюРедактораИнициализированы", Ложь);
	
	Возврат ДанныеРедактора;
КонецФункции

// Новый параметры событий редактора.
// 
// Возвращаемое значение:
//  Структура - Новый параметры событий редактора:
// * ПриИзменении - Строка -
Функция НовыйПараметрыСобытийРедактора() Экспорт
	СобытияРедактора = Новый Структура;
	СобытияРедактора.Вставить("ПриИзменении", "");
	
	Возврат СобытияРедактора;
КонецФункции
 
// Новый данные редактора для сборки обработки.
// 
// Возвращаемое значение:
//  Структура - Новый данные редактора для сборки обработки:
// * Идентификатор - Строка -
// * ИменаПредустановленныхПеременных - Массив из Строка -
// * ТекстРедактора - Строка -
// * ТекстРедактораДляОбработки - Строка -
// * ИсполнениеНаКлиенте - Булево -
// * ИмяПодключаемойОбработки - Строка -
Функция НовыйДанныеРедактораДляСборкиОбработки() Экспорт
	Данные = Новый Структура;
	Данные.Вставить("Идентификатор", "");
	Данные.Вставить("ИменаПредустановленныхПеременных", Новый Массив);
	Данные.Вставить("ТекстРедактора", "");
	Данные.Вставить("ТекстРедактораДляОбработки", "");
	Данные.Вставить("ИсполнениеНаКлиенте", Ложь);
	Данные.Вставить("ИмяПодключаемойОбработки", "");
		
	Возврат Данные;
КонецФункции

// Новый кэш результатов исполнения через обработку.
// 
// Возвращаемое значение:
//  Структура - Новый кэш результатов исполнения через обработку:
// * ИсполнениеНаКлиенте - Булево -
// * ТекстРедактора - Строка -
// * ИменаПредустановленныхПеременных - Массив Из Строка-
Функция НовыйКэшРезультатовПодключенияОбработкиИсполнения() Экспорт
	Кэш = Новый Структура;
	Кэш.Вставить("ИсполнениеНаКлиенте", Ложь);
	Кэш.Вставить("ТекстРедактора", "");
	Кэш.Вставить("ИменаПредустановленныхПеременных", Новый Массив);
	
	Возврат Кэш;
КонецФункции

// Новый параметры сессии взаимодействия.
// 
// Возвращаемое значение:
//  Структура -  Новый параметры сессии взаимодействия:
// * ИмяПользователя - Строка - 
// * Идентификатор - Строка - 
// * URLВзаимодействия - Строка - 
Функция НовыйПараметрыСессииВзаимодействия() Экспорт
	ПараметрыСессииВзаимодействия = Новый Структура;
	ПараметрыСессииВзаимодействия.Вставить("ИмяПользователя", "");
	ПараметрыСессииВзаимодействия.Вставить("Идентификатор","");
	ПараметрыСессииВзаимодействия.Вставить("URLВзаимодействия","");
	
	Возврат ПараметрыСессииВзаимодействия;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ВариантыЯзыкаСинтаксисаРедактораMonaco() Экспорт
	ЯзыкиСинтаксиса = Новый Структура;
	ЯзыкиСинтаксиса.Вставить("Авто", "Авто");
	ЯзыкиСинтаксиса.Вставить("Русский", "Русский");
	ЯзыкиСинтаксиса.Вставить("Английский", "Английский");
	
	Возврат ЯзыкиСинтаксиса;
КонецФункции

Функция ВариантыТемыРедактораMonaco() Экспорт
	Варианты = Новый Структура;
	
	Варианты.Вставить("Светлая", "Светлая");
	Варианты.Вставить("Темная", "Темная");
	
	Возврат Варианты;
КонецФункции

Функция ТемаРедактораMonacoПоУмолчанию() Экспорт
	ТемыРедактора = ВариантыТемыРедактораMonaco();
	
	Возврат ТемыРедактора.Светлая;
КонецФункции
Функция ЯзыкСинтаксисаРедактораMonacoПоУмолчанию() Экспорт
	Варианты = ВариантыЯзыкаСинтаксисаРедактораMonaco();
	
	Возврат Варианты.Авто;
КонецФункции

// Параметры редактора monaco по умолчанию.
// 
// Возвращаемое значение:
//  Структура -  Параметры редактора monaco по умолчанию:
// * ВысотаСтрок - Число - 
// * Тема - Строка - 
// * ЯзыкСинтаксиса - Строка - 
// * ИспользоватьКартуКода - Булево - 
// * СкрытьНомераСтрок - Булево - 
// * ОтображатьПробелыИТабуляции - Булево - 
// * КаталогиИсходныхФайлов - Массив Из Строка - 
// * ФайлыШаблоновКода - Массив из Строка- 
// * ИспользоватьСтандартныеШаблоныКода - Булево - 
// * ИспользоватьКомандыРаботыСБуферомВКонтекстномМеню - Булево - 
Функция ПараметрыРедактораMonacoПоУмолчанию() Экспорт
	ПараметрыРедактора = Новый Структура;
	ПараметрыРедактора.Вставить("ВысотаСтрок", 0);
	ПараметрыРедактора.Вставить("Тема", ТемаРедактораMonacoПоУмолчанию());
	ПараметрыРедактора.Вставить("ЯзыкСинтаксиса", ЯзыкСинтаксисаРедактораMonacoПоУмолчанию());
	ПараметрыРедактора.Вставить("ИспользоватьКартуКода", Ложь);
	ПараметрыРедактора.Вставить("СкрытьНомераСтрок", Ложь);
	ПараметрыРедактора.Вставить("ОтображатьПробелыИТабуляции", Ложь);
	ПараметрыРедактора.Вставить("КаталогиИсходныхФайлов", Новый Массив);
	ПараметрыРедактора.Вставить("ФайлыШаблоновКода", Новый Массив);
	ПараметрыРедактора.Вставить("ИспользоватьСтандартныеШаблоныКода", Истина);
	ПараметрыРедактора.Вставить("ИспользоватьКомандыРаботыСБуферомВКонтекстномМеню", Ложь);
	
	Возврат ПараметрыРедактора;
КонецФункции

Функция ПараметрыРедактораКодаПоУмолчанию() Экспорт
	ПараметрыРедактора = Новый Структура;
	ПараметрыРедактора.Вставить("Вариант",  ВариантРедактораПоУмолчанию());
	ПараметрыРедактора.Вставить("РазмерШрифта", 0);
	ПараметрыРедактора.Вставить("Monaco", ПараметрыРедактораMonacoПоУмолчанию());
	
	Возврат ПараметрыРедактора;
КонецФункции

Функция НовыйОписаниеКаталогаИсходныхФайловКонфигурации() Экспорт
	Описание = Новый Структура;
	Описание.Вставить("Каталог", "");
	Описание.Вставить("Источник", "");
	
	Возврат Описание;
КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДополненныйКонтекстомКодАлгоритма(ТекстАлготима, Контекст)
	ПодготовленныйКод="";

	Для Каждого КлючЗначение Из Контекст Цикл
		ПодготовленныйКод = ПодготовленныйКод +"
		|"+КлючЗначение.Ключ+"=__Контекст__."+КлючЗначение.Ключ+";";
	КонецЦикла;

	ПодготовленныйКод=ПодготовленныйКод + Символы.ПС + ТекстАлготима;

	Возврат ПодготовленныйКод;
КонецФункции



#КонецОбласти