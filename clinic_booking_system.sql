-- Clinic Booking System Database
-- Author: SAMUEL NGASE ACHALA
-- Description: SQL file to create tables and relationships for a clinic booking system

-- Drop database if exists
DROP DATABASE IF EXISTS ClinicDB;

-- Create database
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Department Table
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor Table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Patient Table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Appointment Table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    method ENUM('Cash', 'Credit Card', 'Insurance'),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Medical Record Table
CREATE TABLE MedicalRecord (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    record_date DATE NOT NULL,
    description TEXT,
    diagnosis TEXT,
    prescription TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);