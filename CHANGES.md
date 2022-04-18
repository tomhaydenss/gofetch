# Requirements
✔️ Updated the `get_appointments_by_date/1` function to filter by the given period properly

✔️ Updated appointments to be sorted by their date/time

✔️ Updated the dropdown list to filter appointments by doctor

# Improvements
- Added the `get_appointments_by_date_and_doctor/3` function as an alternative for `get_appointments_by_date/1`. It has an additional filter by `doctor_id` and sort ascending by appointment's `date`. It is ready to be used, but I left it on frontend because I assumed that it's part of the frontend's challenge 
- Added DB index to improve read performance, although we don't have a bunch of data at this moment, it's always good to think in the long term
- Added a Core context on backend to avoid schemas to have query responsibilities, so that we can serve other app's points as a façade.
- Static code analsys (Credo+Dialyzer)
- Security static analysis (Sobelow)
- Code coverage (ExCoveralls)
- Added tests to increase code coverage, now we have 100%. It's better to do it before the project grows
- Added mix task with all checks above to be used in a CI pipeline 
- React Components + UI Improvements 🙈
- Dockerfile

# TODO
Things that I'd like to deliver, but the time was not enough:
- Week selection component to navigate through other weeks
- Build tool using make files 
- CI/CD Pipeline
- API authentication
- Query with pagination

# Tasks
Following, we have a collection of useful tasks and commands to development

## Coding Format
```
mix format
```

## Static code analsys
### with Credo
```
mix credo --strict
```
### with Dialyzer
```
mix dialyzer
```

## Code coverage
```
mix coveralls.html
```

## Security static analysis
```
mix sobelow --config
```

## All above for CI purpose
```
MIX_ENV=test mix quality.ci
```

## Docker
### build
```
docker build -t gofetch .
```
### run
```
docker run -p 80:4000 gofetch:latest
```