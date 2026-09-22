## Оглавление

- [Группа 1. Сотрудники и персонал](#группа-1-сотрудники-и-персонал)
- [Scheme 1](Group%201.canvas)
- [Группа 2. Роли и права](#группа-2-роли-и-права)
- [Группа 3. Структура компании](#группа-3-структура-компании)
- [Группа 4. Проекты](#группа-4-проекты)
- [Группа 5. Задачи и время](#группа-5-задачи-и-время)
- [Группа 6. Отпуска и больничные](#группа-6-отпуска-и-больничные)
- [Группа 7. Навыки и уровни](#группа-7-навыки-и-уровни)
- [Группа 8. Оборудование и ресурсы](#группа-8-оборудование-и-ресурсы)
- [Группа 9. Справочники общего назначения](#группа-9-справочники-общего-назначения)
- [Группа 10. Отчётность и агрегаты](#группа-10-отчётность-и-агрегаты)
- [Примечания](#примечания)

---

<a name="группа-1-сотрудники-и-персонал"></a>
## Группа 1. Сотрудники и персонал

### Employee

Основная таблица сотрудников.

| Поле | Тип | Длина | Точность | NULL | PK | FK | UNIQUE | Источник FK | Примечание |
|------|-----|-------|----------|------|----|----|--------|-------------|------------|
| ID | int | 4 | 10 | NOT NULL | PK | | | | Идентификатор |
| FirstName | nvarchar | 256 | | NOT NULL | | | | | Имя |
| LastName | nvarchar | 256 | | NOT NULL | | | | | Фамилия |
| FullNameOld | nvarchar | 256 | | NULL | | | | | Старое полное имя |
| JobPositionID | int | 4 | 10 | NOT NULL | | FK | | JobPosition.ID | Должность |
| DomainLogin | varchar | 255 | | NULL | | | UNIQUE | | Доменный логин |
| Email | varchar | 1000 | | NULL | | | | | Email |
| Active | bit | 1 | | NOT NULL | | | | | Активен |
| LocationID | int | 4 | 10 | NULL | | FK | | Location.ID | Локация |
| ExternalCompanyID | int | 4 | 10 | NULL | | FK | | (внешняя таблица) | Внешняя компания |
| DepartmentID | int | 4 | 10 | NULL | | FK | | Department.ID | Подразделение |
| SkillID | int | 4 | 10 | NOT NULL | | FK | | Skill.ID | Навык |
| Comment | nvarchar | 2048 | | NULL | | | | | Комментарий |
| Photo | image | 16 | | NULL | | | | | Фотография |
| Phone | nvarchar | 64 | | NULL | | | | | Телефон |
| AlternativePhone | nvarchar | 64 | | NULL | | | | | Доп. телефон |
| ExtraEmail | nvarchar | 128 | | NULL | | | | | Доп. email |
| FullName | nvarchar | 514 | | NOT NULL | | | | | Полное имя (вычисляемое) |
| TerminationDate | datetime | 8 | | NULL | | | | | Дата увольнения |
| ResidentialOfficeID | int | 4 | 10 | NOT NULL | | FK | | Location.ID | Офис проживания |

---

### EmployeeInfo

Дополнительная информация о сотруднике.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| ContactSkype | nvarchar | | NULL | | | | Skype |
| ContactPhoneWork | nvarchar | | NULL | | | | Рабочий телефон |
| SkypeForBusiness | nvarchar | | NULL | | | | Skype для бизнеса |
| Portfolio | nvarchar | | NULL | | | | Портфолио |

---

### EmployeeSettings

Персональные настройки сотрудника.

|Поле|Тип|Длина|NULL|PK|FK|DEFAULT|Источник FK|Примечание|
|---|---|---|---|---|---|---|---|---|
|EmployeeID|int|4|NOT NULL|PK|FK||Employee.ID|Ссылка на сотрудника (1:1)|
|LanguageCode|varchar|5|NOT NULL|||'ru'||Код языка интерфейса (ru, en, de)|
|TimeZone|varchar|50|NOT NULL|||'Europe/Minsk'||Часовой пояс|
|DateFormat|varchar|20|NOT NULL|||'DD.MM.YYYY'||Формат даты|
|TimeFormat|varchar|10|NOT NULL|||'HH:MM'||Формат времени (12/24 ч)|
|Theme|varchar|20|NOT NULL|||'light'||Тема оформления (light, dark, auto)|
|NotifyByEmail|bit|1|NOT NULL|||1||Уведомления по email|
|NotifyByTelegram|bit|1|NOT NULL|||0||Уведомления в Telegram|
|NotifyByPush|bit|1|NOT NULL|||0||Push-уведомления|
|NotifyBySms|bit|1|NOT NULL|||0||SMS-уведомления|
|ItemsPerPage|int|4|NOT NULL|||25||Записей на странице|
|ShowPhotos|bit|1|NOT NULL|||1||Показывать фотографии коллег|
|DefaultSortField|varchar|50|NULL|||'Name'||Поле сортировки по умолчанию|
|DefaultSortOrder|varchar|4|NULL|||'ASC'||Направление сортировки (ASC, DESC)|
|LastLoginDate|datetime|8|NULL|||||Дата последнего входа|
|Preferences|nvarchar|4000|NULL|||||JSON с расширенными настройками|

---

### EmployeeAccess

Доступы сотрудника к системам.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| Access | nvarchar | | NULL | | | | Тип доступа |
| OpenDate | date | 3 | NULL | | | | Дата выдачи |
| CloseDate | date | 3 | NULL | | | | Дата закрытия |
| AccessName | nvarchar | | NULL | | | | Название доступа |

---

### EmployeeSkill

Навыки сотрудника.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| SkillID | int | 4 | NOT NULL | | FK | Skill.ID | Навык |
| Proficiency | nvarchar | | NULL | | | | Уровень владения |
| LevelID | int | 4 | NULL | | FK | SkillLevel.ID | Уровень |
| IsMain | bit | 1 | NULL | | | | Основной навык |
| Info | nvarchar | | NULL | | | | Примечание |

---

### EmployeeRoles

Роли сотрудника.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| EmployeeID | int | 4 | NOT NULL | PK | FK | Employee.ID | Сотрудник |
| RoleID | int | 4 | NOT NULL | PK | FK | Role.ID | Роль |

---

<a name="группа-2-роли-и-права"></a>
## Группа 2. Роли и права

### Role

Справочник ролей сотрудников.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название роли |
| Description | nvarchar | | NULL | | | | Описание |

---

### RoleFeatures

Функции роли.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| RoleID | int | 4 | NOT NULL | PK | FK | Role.ID | Роль |
| FeatureID | int | 4 | NOT NULL | PK | FK | (справочник функций) | Функция |

---

<a name="группа-3-структура-компании"></a>
## Группа 3. Структура компании

### Department

Справочник подразделений.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| DeptCode | nvarchar | | NULL | | | | Код подразделения |
| Name | nvarchar | | NOT NULL | | | | Название |

---

### JobPosition

Справочник должностей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название должности |

---

### Location

Справочник локаций и офисов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название |
| ResidentialOfficeID | int | 4 | NULL | | FK | Location.ID | Офис проживания (самоссылка) |

---

### Customer

Справочник заказчиков (read-only).

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название заказчика |
| LocalCustomerRepID | int | 4 | NULL | | FK | Employee.ID | Представитель заказчика |

---

<a name="группа-4-проекты"></a>
## Группа 4. Проекты

### Project

Основная таблица проектов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название |
| ProjectTypeID | int | 4 | NULL | | FK | Project_Type.ID | Тип проекта |
| ProjectStatusID | int | 4 | NULL | | FK | Project_Status.ID | Статус |
| ProjectSubTypeID | int | 4 | NULL | | FK | Project_SubType.ID | Подтип |
| StartDate | date | 3 | NULL | | | | Дата начала |
| EndDate | date | 3 | NULL | | | | Дата окончания |

---

### Project_Type

Справочник типов проектов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

### Project_Status

Справочник статусов проектов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название статуса |

---

### Project_SubType

Справочник подтипов проектов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название подтипа |

---

### Project_Assignment

Назначения сотрудников на проекты.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| ProjectID | int | 4 | NOT NULL | | FK | Project.ID | Проект |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| RoleID | int | 4 | NULL | | FK | Project_Role.ID | Роль в проекте |
| StartDate | date | 3 | NULL | | | | Дата начала |
| EndDate | date | 3 | NULL | | | | Дата окончания |

---

### Project_Role

Роли сотрудников в проектах.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название роли |

---

### Project_Solution

Решения, использованные в проекте.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| SolutionID | int | 4 | NOT NULL | PK | FK | Solution.ID | Решение |

---

### Project_IndustryTypes

Отрасли проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| IndustryTypeID | int | 4 | NOT NULL | PK | FK | IndustryType.ID | Отрасль |

---

### Project_ManagementSystem

Системы управления проектом.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| ManagementSystemID | int | 4 | NOT NULL | PK | FK | (справочник) | Система управления |

---

### Project_PlanBaseline

Базовый план проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| PlanDate | date | 3 | NULL | | | | Дата плана |
| BaselineDate | date | 3 | NULL | | | | Базовая линия |

---

### Project_PlanInfo

Информация о плане проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| PlanInfo | nvarchar | | NULL | | | | Описание плана |

---

### Project_PlatformTypes

Платформы проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| PlatformTypeID | int | 4 | NOT NULL | PK | FK | PlatformType.ID | Платформа |

---

### Project_ProposalOrQuote

Коммерческие предложения и сметы.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| ProposalID | int | 4 | NULL | | FK | (справочник) | Предложение |
| QuoteID | int | 4 | NULL | | FK | Quote.ID | Смета |

---

### Project_SoftwareCategories

Категории ПО проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| SoftwareCategoryID | int | 4 | NOT NULL | PK | FK | SoftwareCategory.ID | Категория ПО |

---

### Project_SolutionCategories

Категории решений проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| SolutionCategoryID | int | 4 | NOT NULL | PK | FK | SolutionCategory.ID | Категория решения |

---

### Project_UpdatingDate

Даты обновления проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| UpdateDate | datetime | 8 | NULL | | | | Дата обновления |

---

### Project_WebsiteCategories

Категории веб-сайтов проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| WebsiteCategoryID | int | 4 | NOT NULL | PK | FK | WebsiteCategory.ID | Категория сайта |

---

### Project_WeekPlan

Недельные планы проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| WeekID | int | 4 | NOT NULL | PK | FK | WorkingPeriod.ID | Неделя |
| Plan | nvarchar | | NULL | | | | План |

---

### ProjectKickOff

Запуск проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| ProjectID | int | 4 | NOT NULL | | FK | Project.ID | Проект |
| KickOffDate | date | 3 | NULL | | | | Дата запуска |

---

### ProjectKickOffPSAMember

Участники запуска проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| KickOffID | int | 4 | NOT NULL | PK | FK | ProjectKickOff.ID | Запуск |
| EmployeeID | int | 4 | NOT NULL | PK | FK | Employee.ID | Сотрудник |

---

### ProjectKickOffPSATeam

Команда запуска проекта.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| KickOffID | int | 4 | NOT NULL | PK | FK | ProjectKickOff.ID | Запуск |
| TeamID | int | 4 | NOT NULL | PK | FK | (справочник команд) | Команда |

---

<a name="группа-5-задачи-и-время"></a>
## Группа 5. Задачи и время

### TC_Task

Задачи сотрудников.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название |
| ProjectID | int | 4 | NULL | | FK | Project.ID | Проект |
| EmployeeID | int | 4 | NULL | | FK | Employee.ID | Сотрудник |
| StatusID | int | 4 | NULL | | FK | (справочник статусов) | Статус |
| StartDate | date | 3 | NULL | | | | Дата начала |
| EndDate | date | 3 | NULL | | | | Дата окончания |

---

### TC_TaskHistory

История изменений задач.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |
| ChangeType | nvarchar | | NULL | | | | Тип изменения |

---

### TC_TaskLog

Журнал работы по задаче.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| EmployeeID | int | 4 | NOT NULL | PK | FK | Employee.ID | Сотрудник |
| LogDate | date | 3 | NULL | | | | Дата |
| Hours | decimal | | NULL | | | | Часы |

---

### TC_TaskDuration

Длительность задач.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| Duration | int | 4 | NULL | | | | Длительность |

---

### TC_TaskDurationHistory

История длительности задач.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| Duration | int | 4 | NULL | | | | Длительность |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### TC_TaskDurationLog

Журнал длительности задач.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| LogDate | date | 3 | NULL | | | | Дата |
| Duration | int | 4 | NULL | | | | Длительность |

---

### TC_Locks

Блокировки задач.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TaskID | int | 4 | NOT NULL | PK | FK | TC_Task.ID | Задача |
| LockedBy | int | 4 | NULL | | FK | Employee.ID | Кто заблокировал |
| LockDate | datetime | 8 | NULL | | | | Дата блокировки |

---

### TimeCard

Табели учёта рабочего времени.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| Date | date | 3 | NULL | | | | Дата |
| Hours | decimal | | NULL | | | | Часы |

---

### TimeCardHistory

История табелей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TimeCardID | int | 4 | NOT NULL | PK | FK | TimeCard.ID | Табель |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### TimeCardReview

Проверка табелей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| TimeCardID | int | 4 | NOT NULL | PK | FK | TimeCard.ID | Табель |
| ReviewerID | int | 4 | NULL | | FK | Employee.ID | Проверяющий |
| ReviewDate | date | 3 | NULL | | | | Дата проверки |

---

### TimeCardStatus

Справочник статусов табелей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название статуса |

---

### timecardReviewCheckboxFlags

Флаги проверки табелей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| TimeCardReviewID | int | 4 | NOT NULL | | FK | TimeCardReview.TimeCardID | Проверка |
| Flag | bit | 1 | NULL | | | | Флаг |

---

### timecardReviewStarFlags

Звёздные отметки проверки.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| TimeCardReviewID | int | 4 | NOT NULL | | FK | TimeCardReview.TimeCardID | Проверка |
| Star | int | 4 | NULL | | | | Звезда |

---

### WeekAssignment

Назначения на неделю.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| WeekID | int | 4 | NOT NULL | | FK | WorkingPeriod.ID | Неделя |
| ProjectID | int | 4 | NULL | | FK | Project.ID | Проект |

---

### WeekHistoryAssignment

История недельных назначений.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| WeekAssignmentID | int | 4 | NOT NULL | | FK | WeekAssignment.ID | Назначение |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### WeekProjectOverhead

Недельные накладные по проекту.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| WeekID | int | 4 | NOT NULL | PK | FK | WorkingPeriod.ID | Неделя |
| ProjectID | int | 4 | NOT NULL | PK | FK | Project.ID | Проект |
| Overhead | decimal | | NULL | | | | Величина накладных |

---

### WorkingPeriod

Рабочие периоды.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| StartDate | date | 3 | NULL | | | | Начало |
| EndDate | date | 3 | NULL | | | | Окончание |

---

### WorkingPeriodStatus

Статусы рабочих периодов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название |

---

<a name="группа-6-отпуска-и-больничные"></a>
## Группа 6. Отпуска и больничные

### VacationRequest

Заявки на отпуск.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| FromDate | date | 3 | NOT NULL | | | | Дата начала |
| ToDate | date | 3 | NOT NULL | | | | Дата окончания |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| StatusID | int | 4 | NULL | | FK | VacationStatus.ID | Статус |
| Reason | nvarchar | | NULL | | | | Причина |
| RequestDate | date | 3 | NULL | | | | Дата подачи |
| ApproveEmployeeID | int | 4 | NULL | | FK | Employee.ID | Утвердивший |

---

### VacationRequestHistory

История заявок на отпуск.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| VacationRequestID | int | 4 | NOT NULL | | FK | VacationRequest.ID | Заявка |
| StatusID | int | 4 | NULL | | FK | VacationStatus.ID | Статус |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### VacationStatus

Справочник статусов отпусков.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название статуса |

---

### VacationTracking

Отслеживание отпусков.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| VacationRequestID | int | 4 | NOT NULL | | FK | VacationRequest.ID | Заявка |
| StatusID | int | 4 | NULL | | FK | VacationStatus.ID | Статус |

---

### VacationSendNotifyTo

Кому отправлять уведомления об отпуске.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| VacationRequestID | int | 4 | NOT NULL | | FK | VacationRequest.ID | Заявка |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |

---

### UnpaidVacationRequest

Заявки на отпуск без оплаты.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| FromDate | date | 3 | NOT NULL | | | | Начало |
| ToDate | date | 3 | NOT NULL | | | | Окончание |
| StatusID | int | 4 | NULL | | FK | (справочник статусов) | Статус |

---

### UnpaidVacationRequestHistory

История заявок на неоплачиваемый отпуск.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| RequestID | int | 4 | NOT NULL | | FK | UnpaidVacationRequest.ID | Заявка |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### UnpaidVacationSendNotifyTo

Кому отправлять уведомления.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| RequestID | int | 4 | NOT NULL | | FK | UnpaidVacationRequest.ID | Заявка |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |

---

### UnpaidVacationTracking

Отслеживание неоплачиваемых отпусков.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| RequestID | int | 4 | NOT NULL | | FK | UnpaidVacationRequest.ID | Заявка |

---

### SickDayRequest

Заявки на больничный.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| FromDate | date | 3 | NOT NULL | | | | Начало |
| ToDate | date | 3 | NOT NULL | | | | Окончание |
| StatusID | int | 4 | NULL | | FK | (справочник статусов) | Статус |

---

### SickDayRequestHistory

История заявок на больничный.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| RequestID | int | 4 | NOT NULL | | FK | SickDayRequest.ID | Заявка |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### SickDaySendNotifyTo

Кому отправлять уведомления.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| RequestID | int | 4 | NOT NULL | | FK | SickDayRequest.ID | Заявка |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |

---

### SickDayTracking

Отслеживание больничных.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| RequestID | int | 4 | NOT NULL | | FK | SickDayRequest.ID | Заявка |

---

<a name="группа-7-навыки-и-уровни"></a>
## Группа 7. Навыки и уровни

### Skill

Справочник навыков.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название навыка |

---

### SkillLevel

Уровни навыков.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название уровня |

---

### SkillJobPositions

Связь навыков и должностей.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| SkillID | int | 4 | NOT NULL | PK | FK | Skill.ID | Навык |
| JobPositionID | int | 4 | NOT NULL | PK | FK | JobPosition.ID | Должность |

---

<a name="группа-8-оборудование-и-ресурсы"></a>
## Группа 8. Оборудование и ресурсы

### HWOwner

Владельцы оборудования.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Имя владельца |

---

### HWUsage

Использование оборудования.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| HWID | int | 4 | NOT NULL | | FK | (справочник оборудования) | Оборудование |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| StartDate | date | 3 | NULL | | | | Начало |
| EndDate | date | 3 | NULL | | | | Окончание |

---

### HardwareStatus

Статусы оборудования.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название статуса |

---

### HardwareType

Типы оборудования.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

### ITResource

ИТ-ресурсы.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название |
| TypeID | int | 4 | NULL | | FK | ITResourceType.ID | Тип |

---

### ITResourceHistory

История ИТ-ресурсов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| ResourceID | int | 4 | NOT NULL | | FK | ITResource.ID | Ресурс |
| ChangeDate | datetime | 8 | NULL | | | | Дата изменения |

---

### ITResourceState

Состояния ИТ-ресурсов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название состояния |

---

### ITResourceSubType

Подтипы ИТ-ресурсов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название подтипа |

---

### ITResourceType

Типы ИТ-ресурсов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

<a name="группа-9-справочники-общего-назначения"></a>
## Группа 9. Справочники общего назначения

### IndustryType

Отрасли.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название отрасли |

---

### LoginType

Типы логинов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

### NotifyEmployeeList

Список сотрудников для уведомлений.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| EmployeeID | int | 4 | NOT NULL | | FK | Employee.ID | Сотрудник |
| NotifyType | nvarchar | | NULL | | | | Тип уведомления |

---

### Phase

Фазы проектов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название фазы |

---

### PlanMonth

Месяцы планирования.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Month | int | 4 | NULL | | | | Месяц |

---

### PlatformType

Типы платформ.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название платформы |

---

### Provider

Поставщики.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название поставщика |

---

### Quote

Сметы.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название сметы |

---

### RateTable

Таблица ставок.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Rate | decimal | | NULL | | | | Ставка |
| CurrencyID | int | 4 | NULL | | FK | (справочник валют) | Валюта |

---

### Solution

Решения.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название решения |

---

### SolutionCategory

Категории решений.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название категории |

---

### SoftwareCategory

Категории ПО.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название категории |

---

### SourceCodeRepositoryType

Типы репозиториев исходного кода.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

### Test

Тесты.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название теста |

---

### TmpTbl

Временная таблица.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Data | nvarchar | | NULL | | | | Данные |

---

### TriggerType

Типы триггеров.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название типа |

---

### WebsiteCategory

Категории веб-сайтов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название категории |

---

<a name="группа-10-отчётность-и-агрегаты"></a>
## Группа 10. Отчётность и агрегаты

### ReportingDates

Отчётные даты.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| ReportDate | date | 3 | NULL | | | | Дата отчёта |

---

### ReportingDatesStatus

Статусы отчётных дат.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| Name | nvarchar | | NOT NULL | | | | Название статуса |

---

### ReportConfig

Конфигурация отчётов.

| Поле | Тип | Длина | NULL | PK | FK | Источник FK | Примечание |
|------|-----|-------|------|----|----|-------------|------------|
| ID | int | 4 | NOT NULL | PK | | | Идентификатор |
| ReportName | nvarchar | | NOT NULL | | | | Название отчёта |
| Config | nvarchar | | NULL | | | | Конфигурация |

---

<a name="примечания"></a>
## Примечания

1. В таблицах указаны только те поля, которые видны в предоставленных скриншотах. Для большинства служебных таблиц (EmployeeSettings, RoleFeatures и т.п.) полный список может быть больше.
2. Все поля с пометкой **PK** входят в составной первичный ключ.
3. Все поля с пометкой **FK** — внешние ключи, ссылающиеся на указанную таблицу.
4. Поля с пометкой **UNIQUE** — уникальные, не могут повторяться.
5. Тип `image` в MS SQL Server — устаревший тип для хранения бинарных данных; в современных версиях рекомендуется `varbinary(max)`.
6. Для таблиц, где полный список полей неизвестен, указано многоточие (`...`) в колонке «Поле».
7. Таблицы с суффиксом `_History` хранят историю изменений соответствующих сущностей.
8. Таблицы `WeekAssignment`, `Project_WeekPlan`, `WeekProjectOverhead` используют `WorkingPeriod.ID` как ссылку на неделю.