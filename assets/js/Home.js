import React, { useEffect, useState } from "react";
import { useQuery, gql } from "@apollo/client";
import AppointmentList from "./AppointmentList";
import DoctorsDropdown from "./DoctorsDropdown";

import "../css/app.scss";

const LIST_APPOINTMENTS = gql`
  query ListAppointments($startDate: String!, $endDate: String!) {
    appointments(startDate: $startDate, endDate: $endDate) {
      id
      reason
      date

      doctor {
        id
        firstName
        lastName
      }

      user {
        id
        email
        name
      }

      pet {
        id
        name
      }
    }
  }
`;

const LIST_DOCTORS = gql`
  query ListDoctors {
    doctors {
      id
      firstName
      lastName
    }
  }
`;

const getStartOfWeek = (date) => {
  const start = date.setDate(date.getDate() - date.getDay());
  return new Date(start);
};

const getEndOfWeek = (date) => {
  const end = date.setDate(date.getDate() + (6 - date.getDay()));
  return new Date(end);
};

const startDate = getStartOfWeek(new Date());
const endDate = getEndOfWeek(new Date());

/**
 * 1. Update appointments to be sorted by their date/time
 * 2. Update the select to filter appointments by doctor
 * 3. Make any improvements to the code you can
 */
const Home = () => {
  const doctorResult = useQuery(LIST_DOCTORS);
  const { data: doctorData } = doctorResult;
  const [doctors, setDoctors] = useState([]);
  useEffect(() => {
    if (doctorData) {
      setDoctors(doctorData.doctors)
    }
  }, [doctorData]);

  const appointmentResult = useQuery(LIST_APPOINTMENTS, {
    variables: { startDate, endDate },
  });
  const { data: appointmentData } = appointmentResult;
  const [appointments, setAppointments] = useState([]);
  const filterAndSortAppointments = () => {
    return appointmentData.appointments.filter(filter_by_doctor).sort(sort_by_date);
  }
  useEffect(() => {
    if (appointmentData) {
      setAppointments(filterAndSortAppointments);
    }
  }, [appointmentData]);

  const sort_by_date = (one, another) => {
    return new Date(one.date).getTime() - new Date(another.date).getTime();
  }

  const filter_by_doctor = (appointment) => {
    if (currentDoctor == appointment.doctor.id) {
      return appointment;
    }
  }

  const [currentDoctor, setCurrentDoctor] = useState("");

  useEffect(() => {
    if (appointmentData) {
      setAppointments(filterAndSortAppointments);
    }
  }, [currentDoctor])

  return (
    <div className="app">
      <h1>This Week's Appointments</h1>
      <DoctorsDropdown items={doctors} currentDoctor={currentDoctor} setCurrentDoctor={setCurrentDoctor} />
      <AppointmentList items={appointments} />
    </div>
  );
};

export default Home;
