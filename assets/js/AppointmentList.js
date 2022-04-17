import React from 'react'
import Appointment from "./Appointment";

export default function AppointmentList({ items }) {
  return (
    items.map((appointment) => (
      <Appointment appointment={appointment} />
    ))
  )
}