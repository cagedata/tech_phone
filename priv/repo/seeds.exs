# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TechPhone.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TechPhone.{Repo, VoicemailStep}
steps = [
  %VoicemailStep{order: 0, label: "Welcome message", step: %{play: "0-welcome.wav"}},
  %VoicemailStep{order: 1, label: "Phone number", step: %{play: "1-phone_number.wav", action: "gather"}},
  %VoicemailStep{order: 2, label: "Name/Company", step: %{play: "2-name_company.wav", action: "record"}},
  %VoicemailStep{order: 3, label: "Message", step: %{play: "3-description.wav", action: "record"}},
  %VoicemailStep{order: 4, label: "Farewell", step: %{play: "4-thanks.wav", action: "hangup"}}
]

Enum.map steps, fn step -> Repo.insert!(step) end
