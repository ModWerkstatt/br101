function data()
return {
	info = {
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
		    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },
		},
		tags = { "europe", "train", "siemens", "vectron", "smartron", "electric", "multi-system", "universal" },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },
        params = {
			{
				key = "br101_vorspann",
				name = _("vorspann_br101"),
				values = { "No", "Yes", },
				tooltip = _("option_vorspann_br101_desc"),
				defaultIndex = 0,
			},
			{
				key = "br101_fake",
				name = _("fake_br101"),
				values = { "No", "Yes", },
				tooltip = _("option_fake_br101_desc"),
				defaultIndex = 0,
			},
			{
				key = "br101_endless",
				name = _("endjahr_br101"),
				values = { "No", "Yes", },
				tooltip = _("option_endjahr_br101_desc"),
				defaultIndex = 0,
			},
        },
	},
	options = {
	},
	runFn = function (settings, modParams)

		local vorspannFilter = function(fileName, data)
			if data.metadata.transportVehicle and data.metadata.baureihe101 and data.metadata.br101.vorspann == true then
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
				--return false
			end
			--return true
			return data
		end

		local fakeFilter = function(fileName, data)
			if data.metadata.transportVehicle and data.metadata.br101 and data.metadata.br101.fake == true then
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
			end
			return data
		end
		local function endlessFilter(fileName, data)
			if data.metadata.transportVehicle and data.metadata.br101 then
                data.metadata.availability.yearTo = 0
            end
			return data
		end

		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]
			if params["br101_vorspann"] == 0 then
				--addFileFilter("model/transportVehicle", vorspannFilter)
				addModifier("loadModel", vorspannFilter)
			end
			if params["br101_fake"] == 0 then
				addModifier("loadModel", fakeFilter)
			end
            if params["br101_endless"] == 1 then
                addModifier("loadModel", endlessFilter)
            end

		else
			--addFileFilter("model/transportVehicle", vorspannFilter)
			addModifier("loadModel", fakeFilter)
			addModifier("loadModel", endlessFilter)
		end
	end
}
end
