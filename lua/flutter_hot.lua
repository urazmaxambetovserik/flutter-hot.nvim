local M = {}

--- Найти все PID из /tmp/flutter*.pid
local function get_flutter_pids()
	local pids = {}

	local pidfiles = vim.fn.glob("/tmp/flutter*.pid", 0, 1)
	for _, file in ipairs(pidfiles) do
		local f = io.open(file, "r")
		if f then
			local pid = f:read("*l")
			if pid then
				table.insert(pids, pid)
			end
			f:close()
		end
	end

	return pids
end

--- Послать сигнал списку PID
local function send_signal(pids, signal)
	for _, pid in ipairs(pids) do
		local ok, _, code = os.execute("kill -" .. signal .. " " .. pid)
		if not ok or code ~= 0 then
			vim.notify("Failed to send signal to PID " .. pid, vim.log.levels.ERROR)
		end
	end
end

--- Основная функция для команды
local function handle_action(action)
	local pids = get_flutter_pids()
	if #pids == 0 then
		vim.notify("[flutter-hot] No Flutter PIDs found in /tmp", vim.log.levels.WARN)
		return
	end

	if action == "reload" then
		send_signal(pids, "USR1")
	elseif action == "restart" then
		send_signal(pids, "USR2")
	else
		vim.notify("[flutter-hot] Unknown action: " .. action, vim.log.levels.ERROR)
	end
end

--- setup
function M.setup()
	vim.api.nvim_create_user_command("FlutterHot", function(opts)
		handle_action(opts.args)
	end, {
		nargs = 1,
		complete = function()
			return { "reload", "restart" }
		end,
		desc = "Flutter Hot Reload or Restart via signal",
	})
end

return M
