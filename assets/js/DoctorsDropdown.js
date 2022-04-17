import React from 'react'

export default function DoctorsDropdown({ items, currentDoctor, setCurrentDoctor }) {
  function handleDoctorsDropdownChangeEvent(event) {
    setCurrentDoctor(event.target.value);
  }

  return (
    <select value={currentDoctor} onChange={handleDoctorsDropdownChangeEvent}>
      <option value="" disabled hidden>Choose your Doctor here</option>
      {items.map((doctor) => (
        <option value={doctor.id}>Dr. {doctor.lastName}</option>
      ))}
    </select>
  )
}