#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	НачальныйЗаголовок = Заголовок;

	ИнициализироватьФорму();

	Элементы.КодировкаТелаЗапроса.СписокВыбора.Добавить("Системная");
	Элементы.КодировкаТелаЗапроса.СписокВыбора.Добавить("ANSI");
	Элементы.КодировкаТелаЗапроса.СписокВыбора.Добавить("OEM");
	Элементы.КодировкаТелаЗапроса.СписокВыбора.Добавить("UTF8");
	Элементы.КодировкаТелаЗапроса.СписокВыбора.Добавить("UTF16");

	Если Параметры.Свойство("ДанныеОтладки") Тогда
		ЗаполнитьПоДаннымОтладки(Параметры.ДанныеОтладки);
	КонецЕсли;

	УстановитьДоступностьТелаЗапроса(ЭтотОбъект);
	
	УИ_ОбщегоНазначения.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка, Элементы.ГруппаКоманднаяПанельФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИсторияЗапросовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ЗаполнитьДанныеТекущегоЗапросаПоИстории(ВыбраннаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ИсторияЗапросовПриАктивизацииСтроки(Элемент)
	ТекДанные = Элементы.ИсторияЗапросов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если ТекДанные.ВидТелаЗапроса = "Строкой" Тогда
		НоваяСтраница = Элементы.ГруппаИсторияЗапросовТелоЗапросаСтраницаСтрока;
	ИначеЕсли ТекДанные.ВидТелаЗапроса = "ДвоичныеДанные" Тогда
		НоваяСтраница = Элементы.ГруппаИсторияЗапросовТелоЗапросаСтраницаДвоичныеДанные;
	Иначе
		НоваяСтраница = Элементы.ГруппаИсторияЗапросовТелоЗапросаСтраницаФайл;
	КонецЕсли;

	Элементы.ГруппаИсторияЗапросовТелоЗапросаСтраницы.ТекущаяСтраница = НоваяСтраница;

	Если ЭтоАдресВременногоХранилища(ТекДанные.АдресТелаОтветаСтрокой) Тогда
		ТелоОтветаСтрокой = ПолучитьИзВременногоХранилища(ТекДанные.АдресТелаОтветаСтрокой);
	Иначе
		ТелоОтветаСтрокой = "";
	КонецЕсли;

	ЗаголовокНастройкиПроксиАнализаЗапроса = ЗаголовокНастроекПроксиПоПараметрам(ТекДанные.ИспользоватьПрокси,
		ТекДанные.ПроксиСервер, ТекДанные.ПроксиПорт, ТекДанные.ПроксиПользователь, ТекДанные.ПроксиПароль,
		ТекДанные.ПроксиАутентификацияОС);
КонецПроцедуры

&НаКлиенте
Процедура ИсторияЗапросовТелоЗапросаИмяФайлаОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	ТекДанные = Элементы.ИсторияЗапросов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	НачатьЗапускПриложения(УИ_ОбщегоНазначенияКлиент.ПустоеОписаниеОповещенияДляЗапускаПриложения(),
		ТекДанные.ТелоЗапросаИмяФайла);
КонецПроцедуры

&НаКлиенте
Процедура РедактированиеЗаголовковТаблицейПриИзменении(Элемент)
	УстановитьСтраницуРедактированияЗаголовковЗапроса();
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаЗаголовковЗапросаКлючАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание,
	СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	Если Не ЗначениеЗаполнено(Текст) Тогда
		Возврат;
	КонецЕсли;

	ДанныеВыбора = Новый СписокЗначений;

	Для Каждого ЭлементСписка Из СписокИспользованныхЗаголовков Цикл
		Если СтрНайти(НРег(ЭлементСписка.Значение), НРег(Текст)) > 0 Тогда
			ДанныеВыбора.Добавить(ЭлементСписка.Значение);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ВидТелаЗапросаПриИзменении(Элемент)
	ТолькоПросмотрГруппыПараметровСтроковогоТела = Истина;

	Если ВидТелаЗапроса = "Строкой" Тогда
		НоваяСтраница = Элементы.ГруппаСтраницаТелаЗапросаСтрокой;
		ТолькоПросмотрГруппыПараметровСтроковогоТела = Ложь;
	ИначеЕсли ВидТелаЗапроса = "ДвоичныеДанные" Тогда
		НоваяСтраница = Элементы.ГруппаСтраницаТелаЗапросаДвоичныеДанные;
	Иначе
		НоваяСтраница = Элементы.ГруппаСтраницаТелаЗапросаИмяФайлаТела;
	КонецЕсли;

	Элементы.ГруппаСтраницыТелаЗапроса.ТекущаяСтраница = НоваяСтраница;
	Элементы.ГруппаСвойстваСтроковогоТелаЗапроса.ТолькоПросмотр = ТолькоПросмотрГруппыПараметровСтроковогоТела;
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаТелаЗапросаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДВФ.МножественныйВыбор = Ложь;
	ДВФ.ПолноеИмяФайла = ИмяФайлаТелаЗапроса;

	ДВФ.Показать(Новый ОписаниеОповещения("ИмяФайлаТелаЗапросаНачалоВыбораЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ЗапросHTTPПриИзменении(Элемент)
	УстановитьДоступностьТелаЗапроса(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПроксиПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

&НаКлиенте
Процедура ПроксиСерверПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

&НаКлиенте
Процедура ПроксиПортПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

&НаКлиенте
Процедура ПроксиПользовательПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

&НаКлиенте
Процедура ПроксиПарольПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры

&НаКлиенте
Процедура ПроксиАутентификацияОСПриИзменении(Элемент)
	СформироватьЗаголовокНастроекПрокси();
КонецПроцедуры
&НаКлиенте
Процедура URLЗапросаПриИзменении(Элемент)
	ПрочитатьПараметрыИзURL(URLЗапроса);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьЗапрос(Команда)
	Если ВидТелаЗапроса = "Файл" Тогда
		АдресФайлаТелаЗапроса = ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяФайлаТелаЗапроса),
			АдресФайлаТелаЗапроса);
	КонецЕсли;
	ВыполнитьЗапросНаСервере();
	
	//позиционируем историю запросов на текущую строку
//	Если ИсторияЗапросов.Количество() > 0 Тогда
//		Элементы.ИсторияЗапросов.ТекущаяСтрока=ИсторияЗапросов[ИсторияЗапросов.Количество()
//			- 1].ПолучитьИдентификатор();
//	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДвоичныеДанныеТелаИзФайла(Команда)
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗаполнитьДвоичныеДанныеТелаИзФайлаЗавершение", ЭтотОбъект),
		АдресДвоичныхДанныхТелаЗапроса, "", Истина, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДвоичныеДанныеТелаЗапросаИзИстории(Команда)
	ТекДанныеИсторииЗапроса = Элементы.ИсторияЗапросов.ТекущиеДанные;
	Если ТекДанныеИсторииЗапроса = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЭтоАдресВременногоХранилища(ТекДанныеИсторииЗапроса.ТелоЗапросаАдресДвоичныхДанных) Тогда
		Возврат;
	КонецЕсли;

	ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДВФ.МножественныйВыбор = Ложь;

	ПолучаемыеФайлы = Новый Массив;
	ПолучаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(, ТекДанныеИсторииЗапроса.ТелоЗапросаАдресДвоичныхДанных));

	НачатьПолучениеФайлов(Новый ОписаниеОповещения("СохранитьДвоичныеДанныеТелаЗапросаИзИсторииПриЗавершении",
		ЭтотОбъект), ПолучаемыеФайлы, ДВФ, Истина);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьТелоОтветаДвоичныеДанныеВФайл(Команда)
	ТекДанныеИсторииЗапроса = Элементы.ИсторияЗапросов.ТекущиеДанные;
	Если ТекДанныеИсторииЗапроса = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЭтоАдресВременногоХранилища(ТекДанныеИсторииЗапроса.ТелоОтветаАдресДвоичныхДанных) Тогда
		Возврат;
	КонецЕсли;

	ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДВФ.МножественныйВыбор = Ложь;

	ПолучаемыеФайлы = Новый Массив;
	ПолучаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(, ТекДанныеИсторииЗапроса.ТелоОтветаАдресДвоичныхДанных));

	НачатьПолучениеФайлов(Новый ОписаниеОповещения("СохранитьДвоичныеДанныеТелаЗапросаИзИсторииПриЗавершении",
		ЭтотОбъект), ПолучаемыеФайлы, ДВФ, Истина);
КонецПроцедуры

&НаКлиенте
Процедура НовыйФайлЗапросов(Команда)
	Если ИсторияЗапросов.Количество() = 0 Тогда
		ИнициализироватьКонсоль();
	Иначе
		ПоказатьВопрос(Новый ОписаниеОповещения("НовыйФайлЗапросовЗавершение", ЭтотОбъект),
			"История запросов непустая. Продолжить?", РежимДиалогаВопрос.ДаНет, 15, КодВозвратаДиалога.Нет);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗапросов(Команда)
	Если ИсторияЗапросов.Количество() = 0 Тогда
		ЗагрузитьФайлКонсоли();
	Иначе
		ПоказатьВопрос(Новый ОписаниеОповещения("ОткрытьФайлОтчетовЗавершение", ЭтотОбъект),
			"История запросов непустая. Продолжить?", РежимДиалогаВопрос.ДаНет, 15, КодВозвратаДиалога.Нет);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция СтруктураОписанияСохраняемогоФайла()
	Структура=УИ_ОбщегоНазначенияКлиент.ПустаяСтруктураОписанияВыбираемогоФайла();
	Структура.ИмяФайла=ИмяФайлаЗапросов;

	// Пока закоментим сохранение в JSON, т.к. библиотека ошибки выдает на двоичных данных
	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура,
		"Файл запросов консоли HTPP в JSON (*.jhttp)", "jhttp");
	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Файл запросов консоли HTPP (*.xhttp)",
		"xhttp");

	Возврат Структура;
КонецФункции

&НаКлиенте
Процедура СохранитьЗапросыВФайл(Команда)
	УИ_ОбщегоНазначенияКлиент.СохранитьДанныеКонсолиВФайл("КонсольHTTPЗапросов", Ложь,
		СтруктураОписанияСохраняемогоФайла(), ПоместитьДанныеИсторииВоВременноеХранилище(),
		Новый ОписаниеОповещения("СохранениеВФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьЗапросыВФайлКак(Команда)
	УИ_ОбщегоНазначенияКлиент.СохранитьДанныеКонсолиВФайл("КонсольHTTPЗапросов", Истина,
		СтруктураОписанияСохраняемогоФайла(), ПоместитьДанныеИсторииВоВременноеХранилище(),
		Новый ОписаниеОповещения("СохранениеВФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьТелоЗапросаВРедактореJSON(Команда)
	УИ_ОбщегоНазначенияКлиент.РедактироватьJSON(ТелоЗапроса, Ложь,
		Новый ОписаниеОповещения("РедактироватьТелоЗапросаВРедактореJSONЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьТелоЗапросаВРедактореJSONАнализируемогоЗапроса(Команда)
	УИ_ОбщегоНазначенияКлиент.РедактироватьJSON(Элементы.ИсторияЗапросов.ТекущиеДанные.ТелоЗапросаСтрока, Истина);
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьТелоОтветаВРедактореJSONАнализируемогоЗапроса(Команда)
	УИ_ОбщегоНазначенияКлиент.РедактироватьJSON(ТелоОтветаСтрокой, Истина);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	УИ_ОбщегоНазначенияКлиент.Подключаемый_ВыполнитьОбщуюКомандуИнструментов(ЭтотОбъект, Команда);
КонецПроцедуры

#КонецОбласти

#Область ФайлыЗапросов

// Отработка загрузки файла с отчетами из адреса.
&НаКлиенте
Процедура ОтработкаЗагрузкиИзАдреса(Адрес)

	ЗагрузитьФайлКонсолиНаСервере(Адрес);
	ИнициализироватьЗапрос();

	ОбновитьЗаголовок();
	
КонецПроцедуры

// Загрузить файл консоли на сервере.
//
// Параметры:
//  Адрес - адрес хранилища, из которого нужно загрузить файл.
&НаСервере
Процедура ЗагрузитьФайлКонсолиНаСервере(Адрес)

	ТаблицаИстории = Обработки.УИ_КонсольHTTPЗапросов.ДанныеСохраненияИзСериализованнойСтроки(Адрес, ИмяФайлаЗапросов);

	ИсторияЗапросов.Очистить();

	Для Каждого СтрокаТз Из ТаблицаИстории Цикл
		НС = ИсторияЗапросов.Добавить();
		ЗаполнитьЗначенияСвойств(НС, СтрокаТз);

		НС.ТелоЗапросаАдресДвоичныхДанных = ПоместитьВоВременноеХранилище(СтрокаТз.ТелоЗапросаДвоичныеДанные,
			УникальныйИдентификатор);
		НС.ТелоОтветаАдресДвоичныхДанных = ПоместитьВоВременноеХранилище(СтрокаТз.ТелоОтветаДвоичныеДанные,
			УникальныйИдентификатор);
		НС.АдресТелаОтветаСтрокой = ПоместитьВоВременноеХранилище(СтрокаТз.ТелоОтвета, УникальныйИдентификатор);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьФайлКонсолиПослеПомещенияФайла(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ИмяФайлаЗапросов = Результат.ИмяФайла;
	ОтработкаЗагрузкиИзАдреса(Результат.Адрес);

КонецПроцедуры

// Загрузить файл.
//
// Параметры:
//  ЗагружаемоеИмяФайла - имя файла, из которого нужно загрузить. Если имя файла
//						  пустое, то нужно запросить у пользователя имя файла.
&НаКлиенте
Процедура ЗагрузитьФайлКонсоли()

	УИ_ОбщегоНазначенияКлиент.ПрочитатьДанныеКонсолиИзФайла("КонсольHTTPЗапросов",
		СтруктураОписанияСохраняемогоФайла(), Новый ОписаниеОповещения("ЗагрузитьФайлКонсолиПослеПомещенияФайла",
		ЭтотОбъект));

КонецПроцедуры

// Завершение обработчика открытия файла.
&НаКлиенте
Процедура ОткрытьФайлОтчетовЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	ЗагрузитьФайлКонсоли();

КонецПроцедуры

&НаКлиенте
Процедура ИнициализироватьКонсоль()
	ИсторияЗапросов.Очистить();
	ИнициализироватьЗапрос();
КонецПроцедуры

// Завершение обработчика создания нового файла запросов.
&НаКлиенте
Процедура НовыйФайлЗапросовЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;

	ИнициализироватьКонсоль();

КонецПроцедуры

// Завершение обработчика открытия файла.
&НаКлиенте
Процедура СохранениеВФайлЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ИмяФайлаЗапросов=Результат;
	Модифицированность = Ложь;
	ОбновитьЗаголовок();

КонецПроцедуры

// Поместить файл во временное хранилище.
&НаСервере
Функция ПоместитьДанныеИсторииВоВременноеХранилище()

	ТаблицаЗначенийИстории = РеквизитФормыВЗначение("ИсторияЗапросов");

	ТаблицаЗначенийИстории.Колонки.Добавить("ТелоЗапросаДвоичныеДанные");
	ТаблицаЗначенийИстории.Колонки.Добавить("ТелоОтветаДвоичныеДанные");
	ТаблицаЗначенийИстории.Колонки.Добавить("ТелоОтвета");
	Для Каждого СтрокаТЗ Из ТаблицаЗначенийИстории Цикл
		Если ЭтоАдресВременногоХранилища(СтрокаТЗ.ТелоЗапросаАдресДвоичныхДанных) Тогда
			СтрокаТЗ.ТелоЗапросаДвоичныеДанные = ПолучитьИзВременногоХранилища(СтрокаТЗ.ТелоЗапросаАдресДвоичныхДанных);
		КонецЕсли;
		Если ЭтоАдресВременногоХранилища(СтрокаТЗ.ТелоОтветаАдресДвоичныхДанных) Тогда
			СтрокаТЗ.ТелоОтветаДвоичныеДанные = ПолучитьИзВременногоХранилища(СтрокаТЗ.ТелоОтветаАдресДвоичныхДанных);
		КонецЕсли;
		Если ЭтоАдресВременногоХранилища(СтрокаТЗ.АдресТелаОтветаСтрокой) Тогда
			СтрокаТЗ.ТелоОтвета = ПолучитьИзВременногоХранилища(СтрокаТЗ.АдресТелаОтветаСтрокой);
		КонецЕсли;
	КонецЦикла;

	ТаблицаЗначенийИстории.Колонки.Удалить("ТелоЗапросаАдресДвоичныхДанных");
	ТаблицаЗначенийИстории.Колонки.Удалить("ТелоОтветаАдресДвоичныхДанных");
	ТаблицаЗначенийИстории.Колонки.Удалить("АдресТелаОтветаСтрокой");

	Результат = ПоместитьВоВременноеХранилище(ТаблицаЗначенийИстории, УникальныйИдентификатор);
	Возврат Результат;

	СериализаторJSON=Обработки.УИ_ПреобразованиеДанныхJSON.Создать();

	СтруктураИстории=СериализаторJSON.ЗначениеВСтруктуру(ТаблицаЗначенийИстории);
	JSONСтрокаИстории=СериализаторJSON.ЗаписатьОписаниеОбъектаВJSON(СтруктураИстории);
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();

	ЗначениеВФайл(ИмяВременногоФайла, ТаблицаЗначенийИстории);
	Результат = ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяВременногоФайла));

	Попытка
		УдалитьФайлы(ИмяВременногоФайла);
	Исключение
	КонецПопытки;

	Возврат Результат;

КонецФункции


#КонецОбласти

#Область ВыполнениеЗапроса

&НаСервере
Функция ПодготовленноеСоединение(СтруктураURL)
	Порт = Неопределено;
	Если ЗначениеЗаполнено(СтруктураURL.Порт) Тогда
		Порт = СтруктураURL.Порт;
	КонецЕсли;
	Если ИспользоватьПрокси Тогда
		НастройкаПрокси = Новый ИнтернетПрокси(Истина);
		НастройкаПрокси.Установить(СтруктураURL.Схема, ПроксиСервер, ПроксиПорт, ПроксиПользователь, ПроксиПароль,
			ПроксиАутентификацияОС);
	Иначе
		НастройкаПрокси = Неопределено;
	КонецЕсли;

	Если НРег(СтруктураURL.Схема) = "https" Тогда
		СоединениеHTTP = Новый HTTPСоединение(СтруктураURL.Сервер, Порт, , , НастройкаПрокси, Таймаут,
			Новый ЗащищенноеСоединениеOpenSSL);
	Иначе
		СоединениеHTTP = Новый HTTPСоединение(СтруктураURL.Сервер, Порт, , , НастройкаПрокси, Таймаут);
	КонецЕсли;

	Возврат СоединениеHTTP;
КонецФункции

&НаСервере
Функция ПодготовленныйЗапросHTTP(СтруктураURL)
	НовыйЗапрос = Новый HTTPЗапрос;

	СтрокаЗапроса = СтруктураURL.Путь;

	СтрокаПараметров = "";
	Для Каждого КлючЗначение Из СтруктураURL.ПараметрыЗапроса Цикл
		СтрокаПараметров = СтрокаПараметров + ?(Не ЗначениеЗаполнено(СтрокаПараметров), "?", "&") + КлючЗначение.Ключ + "="
			+ КлючЗначение.Значение;
	КонецЦикла;

	НовыйЗапрос.АдресРесурса = СтрокаЗапроса + СтрокаПараметров;
	Если Не ЗапросБезТелаЗапроса(ЗапросHTTP) Тогда
		Если ВидТелаЗапроса = "Строкой" Тогда
			Если ЗначениеЗаполнено(ТелоЗапроса) Тогда
				Если ИспользоватьBOM = 0 Тогда
					БОМ = ИспользованиеByteOrderMark.Авто;
				ИначеЕсли (ИспользоватьBOM = 1) Тогда
					БОМ = ИспользованиеByteOrderMark.Использовать;
				Иначе
					БОМ = ИспользованиеByteOrderMark.НеИспользовать;
				КонецЕсли;

				Если КодировкаТелаЗапроса = "Авто" Тогда
					НовыйЗапрос.УстановитьТелоИзСтроки(ТелоЗапроса, , БОМ);
				Иначе

					НовыйЗапрос.УстановитьТелоИзСтроки(ТелоЗапроса, КодировкаТелаЗапроса, БОМ);
				КонецЕсли;
			КонецЕсли;
		ИначеЕсли ВидТелаЗапроса = "ДвоичныеДанные" Тогда
			ДвоичныеДанныеТела = ПолучитьИзВременногоХранилища(АдресДвоичныхДанныхТелаЗапроса);
			Если ТипЗнч(ДвоичныеДанныеТела) = Тип("ДвоичныеДанные") Тогда
				НовыйЗапрос.УстановитьТелоИзДвоичныхДанных(ДвоичныеДанныеТела);
			КонецЕсли;
		Иначе
			ДвоичныеДанныеТела = ПолучитьИзВременногоХранилища(АдресФайлаТелаЗапроса);
			Если ТипЗнч(ДвоичныеДанныеТела) = Тип("ДвоичныеДанные") Тогда
				Файл = Новый Файл(ИмяФайлаТелаЗапроса);
				ВременныйФайл = ПолучитьИмяВременногоФайла(Файл.Расширение);
				ДвоичныеДанныеТела.Записать(ВременныйФайл);

				НовыйЗапрос.УстановитьИмяФайлаТела(ВременныйФайл);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

	//Теперь нужно установить заголовки запроса
	Если РедактированиеЗаголовковТаблицей Тогда
		Заголовки = Новый Соответствие;

		Для Каждого СтрокаЗаголовка Из ТаблицаЗаголовковЗапроса Цикл
			Заголовки.Вставить(СтрокаЗаголовка.Ключ, СтрокаЗаголовка.Значение);
		КонецЦикла;
	Иначе
		Заголовки = УИ_ОбщегоНазначенияКлиентСервер.ЗаголовкиHTTPЗапросаИзСтроки(ЗаголовкиСтрока);
	КонецЕсли;

	НовыйЗапрос.Заголовки = Заголовки;

	Возврат НовыйЗапрос;
КонецФункции

&НаСервере
Процедура ВыполнитьЗапросНаСервере()
	СтруктураURL = УИ_КоннекторHTTP.РазобратьURL(URLЗапроса);

	СоединениеHTTP = ПодготовленноеСоединение(СтруктураURL);

	НачалоВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Запрос = ПодготовленныйЗапросHTTP(СтруктураURL);
	ДатаНачала = ТекущаяДата();
	Попытка
		Если ЗапросHTTP = "GET" Тогда
			Ответ = СоединениеHTTP.Получить(Запрос);
		ИначеЕсли ЗапросHTTP = "POST" Тогда
			Ответ = СоединениеHTTP.ОтправитьДляОбработки(Запрос);
		ИначеЕсли ЗапросHTTP = "DELETE" Тогда
			Ответ = СоединениеHTTP.Удалить(Запрос);
		ИначеЕсли ЗапросHTTP = "PUT" Тогда
			Ответ = СоединениеHTTP.Записать(Запрос);
		ИначеЕсли ЗапросHTTP = "PATCH" Тогда
			Ответ = СоединениеHTTP.Изменить(Запрос);
		Иначе
			Возврат;
		КонецЕсли;
	Исключение

	КонецПопытки;
	ОкончаниеВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();

	ДлительностьВМилисекундах = ОкончаниеВыполнения - НачалоВыполнения;

	ЗафиксироватьЛогЗапроса(СтруктураURL.Сервер, СтруктураURL.Схема, Запрос, Ответ, ДатаНачала,
		ДлительностьВМилисекундах);

	ДополнитьСписокИспользованныхРанееЗаголовков(Запрос.Заголовки);
КонецПроцедуры

&НаСервере
Процедура ДополнитьСписокИспользованныхРанееЗаголовков(Заголовки)
	Для Каждого КлючЗначение Из Заголовки Цикл
		Если СписокИспользованныхЗаголовков.НайтиПоЗначению(КлючЗначение.Ключ) = Неопределено Тогда
			СписокИспользованныхЗаголовков.Добавить(КлючЗначение.Ключ);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗафиксироватьЛогЗапроса(АдресСервера, Протокол, HTTPЗапрос, HTTPОтвет, ДатаНачала, Длительность)

		//	Если HTTPОтвет = Неопределено Тогда 
	//		Ошибка = Истина;
	//	Иначе 
	//		Ошибка=Не ПроверитьУспешностьВыполненияЗапроса(HTTPОтвет);//.КодСостояния<>КодУспешногоЗапроса;
	//	КонецЕсли;
	ЗаписьЛога = ИсторияЗапросов.Добавить();
	ЗаписьЛога.URL = URLЗапроса;

	ЗаписьЛога.HTTPФункция = ЗапросHTTP;
	ЗаписьЛога.АдресСервера = АдресСервера;
	ЗаписьЛога.Дата = ДатаНачала;
	ЗаписьЛога.ДлительностьВыполнения = Длительность;
	ЗаписьЛога.Запрос = HTTPЗапрос.АдресРесурса;
	ЗаписьЛога.ЗаголовкиЗапроса = УИ_ОбщегоНазначенияКлиентСервер.ПолучитьСтрокуЗаголовковHTTP(HTTPЗапрос.Заголовки);
	ЗаписьЛога.BOM = ИспользоватьBOM;
	ЗаписьЛога.КодировкаТелаЗапроса = КодировкаТелаЗапроса;
	ЗаписьЛога.ВидТелаЗапроса = ВидТелаЗапроса;
	ЗаписьЛога.Таймаут = Таймаут;

	ЗаписьЛога.ТелоЗапросаСтрока = HTTPЗапрос.ПолучитьТелоКакСтроку();

	ДвоичныеДанныеТела = HTTPЗапрос.ПолучитьТелоКакДвоичныеДанные();
	ЗаписьЛога.ТелоЗапросаАдресДвоичныхДанных = ПоместитьВоВременноеХранилище(ДвоичныеДанныеТела,
		УникальныйИдентификатор);
	ЗаписьЛога.ТелоЗапросаДвоичныеДанныеСтрокой = Строка(ДвоичныеДанныеТела);
	ЗаписьЛога.ТелоЗапросаИмяФайла = ИмяФайлаТелаЗапроса;
	ЗаписьЛога.Протокол = Протокол;

	// Прокси
	ЗаписьЛога.ИспользоватьПрокси = ИспользоватьПрокси;
	ЗаписьЛога.ПроксиСервер = ПроксиСервер;
	ЗаписьЛога.ПроксиПорт = ПроксиПорт;
	ЗаписьЛога.ПроксиПользователь = ПроксиПользователь;
	ЗаписьЛога.ПроксиПароль = ПроксиПароль;
	ЗаписьЛога.ПроксиАутентификацияОС = ПроксиАутентификацияОС;

	КодСостояния = ?(HTTPОтвет = Неопределено, 500, HTTPОтвет.КодСостояния);
	ЗаписьЛога.КодСостояния = КодСостояния;

	Если HTTPОтвет = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ЗаголовкиОтвета = УИ_ОбщегоНазначенияКлиентСервер.ПолучитьСтрокуЗаголовковHTTP(HTTPОтвет.Заголовки);
	ЗаписьЛога.ЗаголовкиОтвета = ЗаголовкиОтвета;

	ТелоОтветаСтрокой = HTTPОтвет.ПолучитьТелоКакСтроку();
	Если ЗначениеЗаполнено(ТелоОтветаСтрокой) Тогда
		Если НайтиНедопустимыеСимволыXML(ТелоОтветаСтрокой) = 0 Тогда
			ЗаписьЛога.АдресТелаОтветаСтрокой = ПоместитьВоВременноеХранилище(ТелоОтветаСтрокой,
				УникальныйИдентификатор);
		Иначе
			ЗаписьЛога.АдресТелаОтветаСтрокой = ПоместитьВоВременноеХранилище("Содержит недопустимые символы XML",
				УникальныйИдентификатор);
		КонецЕсли;
	КонецЕсли;
	ДвоичныеДанныеОтвета = HTTPОтвет.ПолучитьТелоКакДвоичныеДанные();
	Если ДвоичныеДанныеОтвета <> Неопределено Тогда
		ЗаписьЛога.ТелоОтветаАдресДвоичныхДанных = ПоместитьВоВременноеХранилище(ДвоичныеДанныеОтвета,
			УникальныйИдентификатор);
			
		ТелоОтветаДвоичныеДанныеСтрокой = Строка(ДвоичныеДанныеОтвета);
		ЗаписьЛога.ТелоОтветаДвоичныеДанныеСтрокой = ТелоОтветаДвоичныеДанныеСтрокой;
	КонецЕсли;

	ИмяФайлаОтвета = HTTPОтвет.ПолучитьИмяФайлаТела();
	Если ИмяФайлаОтвета <> Неопределено Тогда
		Файл = Новый Файл(ИмяФайлаОтвета);
		Если Файл.Существует() Тогда
			ДвоичныеДанныеОтвета = Новый ДвоичныеДанные(ИмяФайлаОтвета);
			ЗаписьЛога.ТелоОтветаАдресДвоичныхДанных = ПоместитьВоВременноеХранилище(ДвоичныеДанныеОтвета,
				УникальныйИдентификатор);
				
			ТелоОтветаДвоичныеДанныеСтрокой = Строка(ДвоичныеДанныеОтвета);
			ЗаписьЛога.ТелоОтветаДвоичныеДанныеСтрокой = ТелоОтветаДвоичныеДанныеСтрокой;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Обновить заголовок формы.
&НаКлиенте
Процедура ОбновитьЗаголовок()

	Заголовок = НачальныйЗаголовок + ?(ИмяФайлаЗапросов <> "", ": " + ИмяФайлаЗапросов, "");

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ЗаголовокНастроекПроксиПоПараметрам(ИспользоватьПрокси, Сервер, Порт, Пользователь, Пароль, АутентификацияОС)

	ПрефиксЗаголовка = "";

	Если ИспользоватьПрокси Тогда
		ЗаголовокГруппыПрокси = ПрефиксЗаголовка + Сервер;
		Если ЗначениеЗаполнено(Порт) Тогда
			ЗаголовокГруппыПрокси = ЗаголовокГруппыПрокси + ":" + Формат(Порт, "ЧГ=0;");
		КонецЕсли;

		Если АутентификацияОС Тогда
			ЗаголовокГруппыПрокси = ЗаголовокГруппыПрокси + "; Аутентификация ОС";
		ИначеЕсли ЗначениеЗаполнено(Пользователь) Тогда
			ЗаголовокГруппыПрокси = ЗаголовокГруппыПрокси + ";" + Пользователь;
		КонецЕсли;

	Иначе
		ЗаголовокГруппыПрокси = ПрефиксЗаголовка + " Не используется";
	КонецЕсли;

	Возврат ЗаголовокГруппыПрокси;
КонецФункции

&НаКлиенте
Процедура СформироватьЗаголовокНастроекПрокси()
	ЗаголовокНастройкиПрокси = ЗаголовокНастроекПроксиПоПараметрам(ИспользоватьПрокси, ПроксиСервер, ПроксиПорт,
		ПроксиПользователь, ПроксиПароль, ПроксиАутентификацияОС);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДвоичныеДанныеТелаЗапросаИзИсторииПриЗавершении(ПолученныеФайлы, ДополнительныеПараметры) Экспорт
	Если ПолученныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ЗапросБезТелаЗапроса(ВидЗапросаHTTP)
	МассивЗапросовБезТела = Новый Массив;
	МассивЗапросовБезТела.Добавить("GET");
	МассивЗапросовБезТела.Добавить("DELETE");

	Возврат МассивЗапросовБезТела.Найти(ВРег(ВидЗапросаHTTP)) <> Неопределено;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьТелаЗапроса(Форма)
	Форма.Элементы.ГруппаТелоЗапроса.ТолькоПросмотр = ЗапросБезТелаЗапроса(Форма.ЗапросHTTP);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДвоичныеДанныеТелаИзФайлаЗавершение(Результат, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	Если Не Результат Тогда
		Возврат;
	КонецЕсли;

	АдресДвоичныхДанныхТелаЗапроса = Адрес;

	ТелоЗапросаДвоичныеДанныеСтрокой = Строка(ПолучитьИзВременногоХранилища(Адрес));
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаТелаЗапросаНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт

	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если ВыбранныеФайлы.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

	ИмяФайлаТелаЗапроса = ВыбранныеФайлы[0];
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуЗаголовковПоСтроке(СтрокаЗаголовков)
	ЗаголовкиПоСтроке = УИ_ОбщегоНазначенияКлиентСервер.ЗаголовкиHTTPЗапросаИзСтроки(СтрокаЗаголовков);

	ТаблицаЗаголовковЗапроса.Очистить();

	Для Каждого КлючЗначение Из ЗаголовкиПоСтроке Цикл
		НС = ТаблицаЗаголовковЗапроса.Добавить();
		НС.Ключ = КлючЗначение.Ключ;
		НС.Значение = КлючЗначение.Значение;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуРедактированияЗаголовковЗапроса()
	Если РедактированиеЗаголовковТаблицей Тогда
		НоваяСтраница = Элементы.ГруппаСтраницаРедактированияЗаголовковЗапросаТаблицей;
	Иначе
		НоваяСтраница = Элементы.ГруппаСтраницаРедактированияЗаголовковЗапросаТекстом;
	КонецЕсли;

	Элементы.ГруппаСраницыРедактированияЗаголовковЗапроса.ТекущаяСтраница = НоваяСтраница;

	//Теперь нужно заполнить заголовки на новой странице по старой странице
	Если РедактированиеЗаголовковТаблицей Тогда
		ЗаполнитьТаблицуЗаголовковПоСтроке(ЗаголовкиСтрока);
	Иначе
		ЗаголовкиСтрока = УИ_ОбщегоНазначенияКлиентСервер.ПолучитьСтрокуЗаголовковHTTP(ТаблицаЗаголовковЗапроса);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеТекущегоЗапросаПоИстории(ВыбраннаяСтрока)

//Нужно установить текущую строку в параметры выполнения запроса
	ТекДанные = ИсторияЗапросов.НайтиПоИдентификатору(ВыбраннаяСтрока);

	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ЗапросHTTP = ТекДанные.HTTPФункция;
	URLЗапроса = ТекДанные.URL;
	ЗаголовкиСтрока = ТекДанные.ЗаголовкиЗапроса;
	ТелоЗапроса = ТекДанные.ТелоЗапросаСтрока;
	КодировкаТелаЗапроса = ТекДанные.КодировкаТелаЗапроса;
	ИспользоватьBOM = ТекДанные.BOM;
	ВидТелаЗапроса = ТекДанные.ВидТелаЗапроса;
	ВидТелаЗапросаПриИзменении(Элементы.ВидТелаЗапроса);
	ИмяФайлаТелаЗапроса = ТекДанные.ТелоЗапросаИмяФайла;
	Таймаут=ТекДанные.Таймаут;

	ИспользоватьПрокси = ТекДанные.ИспользоватьПрокси;
	ПроксиСервер = ТекДанные.ПроксиСервер;
	ПроксиПорт = ТекДанные.ПроксиПорт;
	ПроксиПользователь = ТекДанные.ПроксиПользователь;
	ПроксиПароль = ТекДанные.ПроксиПароль;
	ПроксиАутентификацияОС = ТекДанные.ПроксиАутентификацияОС;

	Если ЭтоАдресВременногоХранилища(ТекДанные.ТелоЗапросаАдресДвоичныхДанных) Тогда
		ДвоичныеДанныеТелаЗапроса = ПолучитьИзВременногоХранилища(ТекДанные.ТелоЗапросаАдресДвоичныхДанных);
		ТелоЗапросаДвоичныеДанныеСтрокой = Строка(ДвоичныеДанныеТелаЗапроса);
		Если ТипЗнч(ДвоичныеДанныеТелаЗапроса) = Тип("ДвоичныеДанные") Тогда
			АдресДвоичныхДанныхТелаЗапроса = ПоместитьВоВременноеХранилище(ДвоичныеДанныеТелаЗапроса,
				АдресДвоичныхДанныхТелаЗапроса);
		КонецЕсли;
	КонецЕсли;

	ТаблицаЗаголовковЗапроса.Очистить();
	Если РедактированиеЗаголовковТаблицей Тогда
		ЗаполнитьТаблицуЗаголовковПоСтроке(ЗаголовкиСтрока);
	КонецЕсли;
	ПрочитатьПараметрыИзURL(URLЗапроса);

	//Элементы.ГруппаСтраницыЗапроса.ТекущаяСтраница = Элементы.ГруппаЗапрос;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоДаннымОтладки(АдресДанныхОтладки)
	ДанныеДляОтладки = ПолучитьИзВременногоХранилища(АдресДанныхОтладки);

	URLЗапроса = "";
	Если Не ЗначениеЗаполнено(ДанныеДляОтладки.Протокол) Тогда
		URLЗапроса = "http";
	Иначе
		URLЗапроса = ДанныеДляОтладки.Протокол;
	КонецЕсли;

	URLЗапроса = URLЗапроса + "://" + ДанныеДляОтладки.АдресСервера;

	Если ЗначениеЗаполнено(ДанныеДляОтладки.Порт) Тогда
		URLЗапроса = URLЗапроса + ":" + Формат(ДанныеДляОтладки.Порт, "ЧГ=0;");
	КонецЕсли;

	Если Не СтрНачинаетсяС(ДанныеДляОтладки.Запрос, "/") Тогда
		URLЗапроса = URLЗапроса + "/";
	КонецЕсли;

	URLЗапроса = URLЗапроса + ДанныеДляОтладки.Запрос;
	РедактированиеЗаголовковТаблицей = Истина;

	Элементы.ГруппаСраницыРедактированияЗаголовковЗапроса.ТекущаяСтраница = Элементы.ГруппаСтраницаРедактированияЗаголовковЗапросаТаблицей;

	Заголовки = ДанныеДляОтладки.Заголовки;

	//Удаляем неиспользуемые символы из строки заголовков
	ПозицияСимвола = НайтиНедопустимыеСимволыXML(Заголовки);
	Пока ПозицияСимвола > 0 Цикл
		Если ПозицияСимвола = 1 Тогда
			Заголовки = Сред(Заголовки, 2);
		ИначеЕсли ПозицияСимвола = СтрДлина(Заголовки) Тогда
			Заголовки = Лев(Заголовки, СтрДлина(Заголовки) - 1);
		Иначе
			НовыеЗаголовки = Лев(Заголовки, ПозицияСимвола - 1) + Сред(Заголовки, ПозицияСимвола + 1);
			Заголовки = НовыеЗаголовки;
		КонецЕсли;

		ПозицияСимвола = НайтиНедопустимыеСимволыXML(Заголовки);
	КонецЦикла;

	ЗаполнитьТаблицуЗаголовковПоСтроке(Заголовки);

	Если ДанныеДляОтладки.ТелоЗапроса = Неопределено Тогда
		ТелоЗапроса = "";
	Иначе
		ТелоЗапроса = ДанныеДляОтладки.ТелоЗапроса;
	КонецЕсли;

	Если ДанныеДляОтладки.Свойство("ДвоичныеДанныеТела") Тогда
		Если ТипЗнч(ДанныеДляОтладки.ДвоичныеДанныеТела) = Тип("ДвоичныеДанные") Тогда
			АдресДвоичныхДанныхТелаЗапроса = ПоместитьВоВременноеХранилище(ДанныеДляОтладки.ДвоичныеДанныеТела,
				АдресДвоичныхДанныхТелаЗапроса);
			ТелоЗапросаДвоичныеДанныеСтрокой = ДанныеДляОтладки.ДвоичныеДанныеТелаСтрокой;
		КонецЕсли;
	КонецЕсли;
	Если ДанныеДляОтладки.Свойство("ИмяФайлаЗапроса") Тогда
		ИмяФайлаТелаЗапроса = ДанныеДляОтладки.ИмяФайлаЗапроса;
	КонецЕсли;

	Если ЗначениеЗаполнено(ДанныеДляОтладки.ПроксиСервер) Тогда
		ИспользоватьПрокси = Истина;

		ПроксиСервер = ДанныеДляОтладки.ПроксиСервер;
		ПроксиПорт = ДанныеДляОтладки.ПроксиПорт;
		ПроксиПользователь = ДанныеДляОтладки.ПроксиПользователь;
		ПроксиПароль = ДанныеДляОтладки.ПроксиПароль;
		ПроксиАутентификацияОС = ДанныеДляОтладки.ИспользоватьАутентификациюОС;
	Иначе
		ИспользоватьПрокси = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьФорму()
	ЗапросHTTP = "GET";
	КодировкаТелаЗапроса = "Авто";
	ВидТелаЗапроса = "Строкой";
	Таймаут=30;
	АдресФайлаТелаЗапроса = ПоместитьВоВременноеХранилище(Новый Структура, УникальныйИдентификатор);
	АдресДвоичныхДанныхТелаЗапроса = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ИнициализироватьЗапрос()
	ЗапросHTTP = "GET";
	КодировкаТелаЗапроса = "Авто";
	ВидТелаЗапроса = "Строкой";
	АдресФайлаТелаЗапроса = ПоместитьВоВременноеХранилище(Новый Структура, УникальныйИдентификатор);
	АдресДвоичныхДанныхТелаЗапроса = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
	URLЗапроса = "";
	ИспользоватьBOM = 0;

	//прокси
	ИспользоватьПрокси = Ложь;
	ПроксиСервер = "";
	ПроксиПорт = 0;
	ПроксиПользователь = "";
	ПроксиПароль = "";
	ПроксиАутентификацияОС = Ложь;

	ЗаголовкиСтрока = "";
	ТаблицаЗаголовковЗапроса.Очистить();

	ТелоЗапроса = "";
	ТелоЗапросаДвоичныеДанныеСтрокой = "";
	ИмяФайлаТелаЗапроса = "";
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьТелоЗапросаВРедактореJSONЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ТелоЗапроса=Результат;
КонецПроцедуры
#КонецОбласти

#Область ПараметрыЗапроса

&НаКлиенте
Процедура ПараметрыЗапросаПриИзменении(Элемент)
	стрПараметры = ПодготовитьСтрокуПараметров();
	
	Если Не ПустаяСтрока(стрПараметры) Тогда
		ПодставитьПараметрыВURL(стрПараметры);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗапросаПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если НоваяСтрока Тогда
		Элементы.ПараметрыЗапроса.ТекущиеДанные.Использовать = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьПараметрыИзURL(стрURL)
	ПараметрыЗапроса.Очистить();
	
	ПоложениеПараметров = СтрНайти(стрURL, "?");
	
	Если ПоложениеПараметров > 0 Тогда
		стрПараметры = Прав(стрURL, СтрДлина(стрURL)-ПоложениеПараметров);
		
		мПараметры = СтрРазделить(стрПараметры, "&");
		Для Каждого стрПарам Из мПараметры Цикл
			МассивИмяЗнач = СтрРазделить(стрПарам, "=");
			
			Если МассивИмяЗнач.Количество() = 2 Тогда
				НоваяСтрока = ПараметрыЗапроса.Добавить();
				НоваяСтрока.Использовать = Истина;
				НоваяСтрока.Имя = МассивИмяЗнач[0];
				НоваяСтрока.Значение = МассивИмяЗнач[1];
			КонецЕсли;
			 
		КонецЦикла;	
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ПодготовитьСтрокуПараметров()
		стрПараметры = "";
		
	Для Каждого стрПараметра Из ПараметрыЗапроса Цикл
		Если стрПараметра.Использовать Тогда
			Если ПустаяСтрока(стрПараметры) Тогда
				стрПараметры = СтрШаблон("%1=%2", стрПараметра.Имя, стрПараметра.Значение);
			Иначе
				стрПараметры = стрПараметры+"&"+СтрШаблон("%1=%2", стрПараметра.Имя, стрПараметра.Значение);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат стрПараметры;
КонецФункции

&НаКлиенте
Процедура ПодставитьПараметрыВURL(стрПараметры)
	ПоложениеПараметров = СтрНайти(URLЗапроса, "?");
	
	Если ПоложениеПараметров > 0 Тогда
		URLДоПараметров = Лев(URLЗапроса, ПоложениеПараметров-1);
	Иначе
		URLДоПараметров = URLЗапроса;
	КонецЕсли;
	
	URLЗапроса = СтрШаблон("%1?%2", URLДоПараметров, стрПараметры);
КонецПроцедуры




#КонецОбласти