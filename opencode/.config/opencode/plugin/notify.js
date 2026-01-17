export const NotificationPlugin = async ({ $, client, directory }) => {
  const getSessionTitle = async (sessionID) => {
    try {
      const { data } = await client.GET("/session/{id}", {
        params: { path: { id: sessionID } },
      })
      return data?.title || sessionID
    } catch {
      return sessionID
    }
  }

  const workdir = directory.split("/").pop() || directory

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        const sessionID = event.properties.sessionID
        const sessionTitle = await getSessionTitle(sessionID)
        const message = `Session completed!\\n${workdir} · ${sessionTitle}`
        await $`osascript -e ${"display notification \"" + message + "\" with title \"OpenCode\""}`
      }
      if (event.type === "session.error") {
        const sessionID = event.properties.sessionID
        const sessionTitle = sessionID ? await getSessionTitle(sessionID) : "Unknown"
        const message = `Session error occurred\\n${workdir} · ${sessionTitle}`
        await $`osascript -e ${"display notification \"" + message + "\" with title \"OpenCode\" sound name \"Basso\""}`
      }
    },
  }
}
