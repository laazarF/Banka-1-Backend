package main

import (
	"banka1.com/listings/securities"
	"banka1.com/listings/tax"
	"banka1.com/portfolio"
	"banka1.com/routes"
	fiberSwagger "github.com/swaggo/fiber-swagger"

	"banka1.com/controllers/orders"

	"fmt"
	"os"
	"time"

	"banka1.com/cron"

	// options "banka1.com/listings/options"
	"banka1.com/middlewares"

	"banka1.com/db"
	_ "banka1.com/docs"
	"banka1.com/exchanges"
	"banka1.com/listings/forex"
	"banka1.com/listings/futures"
	"banka1.com/listings/stocks"
	"banka1.com/types"
	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"

	"log"
)

//	@title			Trading Service
//	@version		1.0
//	@description	Trading Service API

// @securityDefinitions.apikey	BearerAuth
// @in							header
// @name						Authorization
// @description				Unesite token. Primer: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
func main() {

	err := godotenv.Load()
	if err != nil {
		panic("Error loading .env file")
	}

	db.Init()
	cron.StartScheduler()

	err = exchanges.LoadDefaultExchanges()
	if err != nil {
		log.Printf("Warning: Failed to load exchanges: %v", err)
	}

	func() {
		log.Println("Starting to load default stocks...")
		stocks.LoadDefaultStocks()
		log.Println("Finished loading default stocks")
	}()

	func() {
		log.Println("Starting to load default forex pairs...")
		forex.LoadDefaultForexPairs()
		log.Println("Finished loading default forex pairs")
	}()

	func() {
		log.Println("Starting to load default futures...")
		err = futures.LoadDefaultFutures()
		if err != nil {
			log.Printf("Warning: Failed to load futures: %v", err)
		}
		log.Println("Finished loading default futures")
	}()

	//func() {
	//	log.Println("Starting to load default options...")
	//	err = options.LoadAllOptions()
	//	if err != nil {
	//		log.Printf("Warning: Failed to load options: %v", err)
	//	}
	//	log.Println("Finished loading default options")
	//}()

	func() {
		log.Println("Starting to load default securities...")
		securities.LoadAvailableSecurities()
		log.Println("Finished loading default securities")
	}()

	func() {
		log.Println("Starting to load default taxes...")
		tax.LoadTax()
		log.Println("Finished loading default taxes")
	}()

	func() {
		log.Println("Starting to load default portfolios...")
		portfolio.LoadPortfolios()
		log.Println("Finished loading default portfolios")
	}()

	func() {
		log.Println("Starting to load default orders...")
		orders.LoadOrders()
		log.Println("Finished loading default orders")
	}()

	app := fiber.New()

	app.Use(func(c *fiber.Ctx) error {
		c.Set("Access-Control-Allow-Origin", "*")
		c.Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
		return c.Next()
	})

	app.Get("/", middlewares.Auth, middlewares.DepartmentCheck("AGENT"), func(c *fiber.Ctx) error {
		response := types.Response{
			Success: true,
			Data:    "Hello, World!",
			Error:   "",
		}
		return c.JSON(response)
	})

	app.Get("/health", func(c *fiber.Ctx) error {
		return c.SendStatus(200)
	})

	routes.SetupRoutes(app)

	// svaki put kad menjate swagger dokumentaciju (komentari iznad funkcija u controllerima), uradite "swag init" da bi se azuriralo
	app.Get("/swagger/*", fiberSwagger.WrapHandler)

	ticker := time.NewTicker(5000 * time.Millisecond)
	done := make(chan bool)

	go func() {
		for {
			select {
			case <-done:
				return
			case <-ticker.C:
				checkUncompletedOrders()
			}
		}
	}()

	port := os.Getenv("LISTEN_PATH")
	log.Printf("Swagger UI available at http://localhost%s/swagger/index.html", port)
	log.Fatal(app.Listen(port))

	ticker.Stop()
	done <- true
}

func checkUncompletedOrders() {
	var undoneOrders []types.Order

	fmt.Println("Proveravanje neizvršenih naloga...")

	db.DB.Where("status = ? AND is_done = ?", "approved", false).Find(&undoneOrders)
	fmt.Printf("Pronadjeno %v neizvršenih naloga\n", len(undoneOrders))
	previousLength := -1

	for len(undoneOrders) > 0 && previousLength != len(undoneOrders) {
		fmt.Printf("Preostalo još %v neizvršenih naloga\n", len(undoneOrders))
		for _, order := range undoneOrders {
			if orders.CanExecuteAny(order) {
				orders.MatchOrder(order)
				break
			}
		}
		previousLength = len(undoneOrders)
		db.DB.Where("status = ? AND is_done = ?", "approved", false).Find(&undoneOrders)
	}
}
