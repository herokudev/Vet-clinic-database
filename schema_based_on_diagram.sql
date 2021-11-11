DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS medical_histories CASCADE;
DROP TABLE IF EXISTS treatments CASCADE;
DROP TABLE IF EXISTS treatment_histories;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS invoice_items;


CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name varchar(120) NOT NULL,
  date_of_birth date,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at timestamp NOT NULL,
  patient_id INT,
  status varchar,
  CONSTRAINT fk_patient_id
      FOREIGN KEY(patient_id)
        REFERENCES patients(id)
          ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE INDEX patient_id_idx ON medical_histories(patient_id);

CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  type varchar NOT NULL,
  name varchar NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE treatment_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT fk_medical_history_id
      FOREIGN KEY(medical_history_id)
        REFERENCES medical_histories(id)
          ON DELETE CASCADE,
  CONSTRAINT fk_treatment_id
      FOREIGN KEY(treatment_id)
        REFERENCES treatments(id)
          ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE INDEX medical_history_id_idx ON treatment_histories(medical_history_id);
CREATE INDEX treatment_id_idx ON treatment_histories(treatment_id);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount decimal NOT NULL,
  generated_at timestamp NOT NULL,
  payed_at timestamp NOT NULL,
  medical_history_id int,
  CONSTRAINT fk_medical_history_id
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id)
        ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE INDEX invoices_medical_history_id_idx ON invoices(medical_history_id);



CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price decimal NOT NULL,
  quantity INT NOT NULL,
  total_price decimal NOT NULL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id
      FOREIGN KEY(invoice_id)
        REFERENCES invoices(id)
          ON DELETE CASCADE,
  CONSTRAINT fk_treatment_id
      FOREIGN KEY(treatment_id)
        REFERENCES treatments(id)
          ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE INDEX invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX invoice_items_treatment_id_idx ON invoice_items(treatment_id);