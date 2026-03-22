//
//  EditRestaurantViewController.swift
//  Spacial OClock
//
//  Created by Ranpreet Singh on 17/03/26.
//

import UIKit

class EditRestaurantViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UI Elements
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let nameField = UITextField()
    let locationField = UITextField()
    let countryField = UITextField()
    let stateField = UITextField()
    let cityField = UITextField()
    let openTimeField = UITextField()
    let closeTimeField = UITextField()
    let descriptionTextView = UITextView()
    
    let profileImageView = UIImageView()
    let collectionView: UICollectionView
    
    let saveButton = UIButton()
    
    var restaurantImages: [String] = []
    
    // Time Pickers
    let openTimePicker = UIDatePicker()
    let closeTimePicker = UIDatePicker()
    
    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Edit Restaurant"
        
        setupUI()
        setupConstraints()
        setupTimePickers()
        loadData()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        setupTextField(nameField, placeholder: "Restaurant Name")
        setupTextField(locationField, placeholder: "Location")
        setupTextField(countryField, placeholder: "Country")
        setupTextField(stateField, placeholder: "State")
        setupTextField(cityField, placeholder: "City")
        setupTextField(openTimeField, placeholder: "Open Time")
        setupTextField(closeTimeField, placeholder: "Close Time")
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.backgroundColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 10
        profileImageView.isUserInteractionEnabled = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImageView.addGestureRecognizer(tap)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        [profileImageView, nameField, locationField, countryField, stateField, cityField, openTimeField, closeTimeField, descriptionTextView, collectionView, saveButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Time Picker Setup
    func setupTimePickers() {
        openTimePicker.datePickerMode = .time
        closeTimePicker.datePickerMode = .time
        
        if #available(iOS 14.0, *) {
            openTimePicker.preferredDatePickerStyle = .wheels
            closeTimePicker.preferredDatePickerStyle = .wheels
        }
        
        openTimeField.inputView = openTimePicker
        closeTimeField.inputView = closeTimePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickingTime))
        toolbar.setItems([doneBtn], animated: false)
        
        openTimeField.inputAccessoryView = toolbar
        closeTimeField.inputAccessoryView = toolbar
    }
    
    @objc func donePickingTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if openTimeField.isFirstResponder {
            openTimeField.text = formatter.string(from: openTimePicker.date)
        } else if closeTimeField.isFirstResponder {
            closeTimeField.text = formatter.string(from: closeTimePicker.date)
        }
        
        view.endEditing(true)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            locationField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            locationField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            locationField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            countryField.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 10),
            countryField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            countryField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            stateField.topAnchor.constraint(equalTo: countryField.bottomAnchor, constant: 10),
            stateField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            stateField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            cityField.topAnchor.constraint(equalTo: stateField.bottomAnchor, constant: 10),
            cityField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            cityField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            openTimeField.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 10),
            openTimeField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            openTimeField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            closeTimeField.topAnchor.constraint(equalTo: openTimeField.bottomAnchor, constant: 10),
            closeTimeField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            closeTimeField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            descriptionTextView.topAnchor.constraint(equalTo: closeTimeField.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130),
            
            saveButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Load Data
    func loadData() {
        nameField.text = "Sky Lounge Bar"
        locationField.text = "Dubai Marina"
        countryField.text = "India"
        stateField.text = "Punjab"
        cityField.text = "Mohali"
        openTimeField.text = "10:00"
        closeTimeField.text = "23:00"
        descriptionTextView.text = "Best rooftop lounge in Dubai"
        
        restaurantImages = ["uploads/restaurants/img1.jpg", "uploads/restaurants/img2.jpg"]
    }
    
    // MARK: - Actions
    @objc func saveTapped() {
        print("Save API Call Here with updated fields")
    }
    
    @objc func selectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // MARK: - Image Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - Collection View
extension EditRestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
}
