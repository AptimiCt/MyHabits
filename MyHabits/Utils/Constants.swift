//
//  Constants.swift
//  MyHabits
//
//  Created by Александр Востриков on 09.04.2022.
//

import UIKit

struct Constants {
    //MARK: - HabitsViewController
    static let titleForHabitsVC = "Сегодня"
    static let lightGrayColor = "LightGrayColor"
    static let habitCollectionViewCell = String(describing: HabitCollectionViewCell.self)
    static let progressCollectionViewCell = String(describing: ProgressCollectionViewCell.self)
    
    
    //MARK: - InfoViewController
    static let titleForInfoVC = "Информация"
    static let titleLabelForInfoVC = "Привычка за 21 день"
    static let textLabelForInfoVC =
            """
            Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
            
            1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
            
            2. Выдержать 2 дня в прежнем состоянии самоконтроля.
            
            3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
            
            4. Поздравить себя с прохождением первого серьезного порога в 21 день.
            За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
            
            5. Держать планку 40 дней.
            Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
            
            6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
            """
    static let footNoteLabelText = "Источник: psychbook.ru"
    //MARK: - HabitViewController
    static let titleTextFieldPlaceholder = "Бегать по утрам, спать 8 часов и т.п."
    static let deleteButtonTitle = "Удалить привычку"
    
    static let titleLabelForHabitVC = "НАЗВАНИЕ"
    static let colorLabelText = "ЦВЕТ"
    static let timeLabelText = "ВРЕМЯ"
    
    static let leftButtonItemTitle = "Отменить"
    static let rightButtonItemTitle = "Сохранить"
    static let navigationItemTitleCreate = "Создать"
    static let navigationItemTitleEdit = "Править"
    static let alertTitle = "Удалить привычку"
    static let colorPickerTitle = "Выбор цвета"
}
