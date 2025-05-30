import { column, defineDb, defineTable } from "astro:db"

const bookings = defineTable({
	columns: {
		facility: column.text(),
		date: column.date(),
		startDate: column.date(),
		endDate: column.date(),

		bookerName: column.text(),
		bookerEmail: column.text(),
		bookerPhone: column.text(),
		bookerPaymentInfo: column.text(),
		paidDate: column.date({ optional: true }),
	},
})

export default defineDb({
	tables: {
		bookings,
	},
})
