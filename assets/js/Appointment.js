import React from 'react'

export default function Appointment({ appointment }) {
  return (
    <div className="appointment">
      <span className="appointment-date">{new Date(appointment.date).toLocaleString()}</span>
      <span>
        {appointment.pet.name} (owner: {appointment.user.name})
      </span>
    </div>
  )
}