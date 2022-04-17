import React from 'react'

export default function Appointment({ appointment }) {
  return (
    <div className="appointment">
      <span className="appointment-date">{appointment.date}</span>
      <span>
        {appointment.pet.name} (owner: {appointment.user.name})
      </span>
    </div>
  )
}