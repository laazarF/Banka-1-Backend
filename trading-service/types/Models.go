package types

type Actuary struct {
	ID           uint    `gorm:"primaryKey" json:"id,omitempty"`
	UserID       uint    `gorm:"uniqueIndex;not null" json:"userId"`
	Department   string  `gorm:"type:text;not null" json:"department,omitempty"`
	FullName     string  `gorm:"not null" json:"fullName"`
	Email        string  `gorm:"not null" json:"email"`
	LimitAmount  float64 `gorm:"default:null" json:"limit"`         // Samo za agente
	UsedLimit    float64 `gorm:"default:0" json:"usedLimit"`        // Samo za agente, resetuje se dnevno
	NeedApproval bool    `gorm:"default:false" json:"needApproval"` // Da li orderi agenta trebaju supervizorsko odobrenje
}

type Security struct {
	ID             uint     `gorm:"primaryKey" json:"id,omitempty"`
	UserID         uint     `gorm:"not null" json:"userId,omitempty"`
	Ticker         string   `gorm:"unique;not null" json:"ticker,omitempty"`
	Name           string   `gorm:"not null" json:"name,omitempty"`
	Type           string   `gorm:"type:text;not null" json:"type,omitempty"`
	Exchange       string   `gorm:"not null" json:"exchange,omitempty"`
	LastPrice      float64  `gorm:"not null" json:"lastPrice,omitempty"`
	AskPrice       float64  `gorm:"default:null" json:"ask,omitempty"`
	BidPrice       float64  `gorm:"default:null" json:"bid,omitempty"`
	Volume         int64    `gorm:"default:0" json:"availableQuantity,omitempty"`
	SettlementDate *string  `gorm:"default:null" json:"settlementDate,omitempty"` // Samo za futures i opcije
	ContractSize   int64    `gorm:"not null" json:"contractSize"`
	StrikePrice    *float64 `gorm:"default:null" json:"strikePrice,omitempty"`
	OptionType     *string  `gorm:"default:null" json:"optionType,omitempty"`
	PreviousClose  float64  `gorm:"default:null" json:"previousClose,omitempty"`
	// data for futures
}

type Order struct {
	ID                uint     `gorm:"primaryKey"`
	UserID            uint     `gorm:"not null"`
	AccountID         uint     `gorm:"not null"`
	SecurityID        uint     `gorm:"not null"`
	OrderType         string   `gorm:"type:text;not null"`
	Quantity          int      `gorm:"not null"`
	ContractSize      int      `gorm:"default:1"`
	StopPricePerUnit  *float64 `gorm:"default:null"`
	LimitPricePerUnit *float64 `gorm:"default:null"`
	Direction         string   `gorm:"type:text;not null"`
	Status            string   `gorm:"type:text;default:'pending'"`
	ApprovedBy        *uint    `gorm:"default:null"` // Supervizor koji je odobrio order
	IsDone            bool     `gorm:"default:false"`
	LastModified      int64    `gorm:"autoUpdateTime"`
	RemainingParts    *int     `gorm:"default:null"`
	AfterHours        bool     `gorm:"default:false"`
	AON               bool     `gorm:"default:false"`
	Margin            bool     `gorm:"default:false"`
	User              uint     `gorm:"foreignKey:UserID"`
	Account           uint     `gorm:"foreignKey:AccountID"`
	Security          Security `gorm:"foreignKey:SecurityID"`
	ApprovedByUser    *uint    `gorm:"foreignKey:ApprovedBy"`
}

type OTCTrade struct {
	ID           uint     `gorm:"primaryKey"`
	SellerID     uint     `gorm:"not null"`
	BuyerID      *uint    `gorm:"default:null"` // NULL dok se ne nađe kupac
	SecurityID   uint     `gorm:"not null"`
	Quantity     int      `gorm:"not null"`
	PricePerUnit float64  `gorm:"not null"`
	Status       string   `gorm:"type:text;default:'pending'"`
	CreatedAt    int64    `gorm:"autoCreateTime"`
	Seller       uint     `gorm:"foreignKey:SellerID"`
	Buyer        *uint    `gorm:"foreignKey:BuyerID"`
	Security     Security `gorm:"foreignKey:SecurityID"`
}

type Portfolio struct {
	ID            uint     `gorm:"primaryKey" json:"id,omitempty"`
	UserID        uint     `gorm:"not null" json:"user_id,omitempty"`
	SecurityID    uint     `gorm:"not null" json:"security_id,omitempty"`
	Quantity      int      `gorm:"not null" json:"quantity,omitempty"`
	PurchasePrice float64  `gorm:"not null" json:"purchase_price,omitempty"`
	CreatedAt     int64    `gorm:"autoCreateTime" json:"created_at,omitempty"`
	User          uint     `gorm:"foreignKey:UserID" json:"user,omitempty"`
	Security      Security `gorm:"foreignKey:SecurityID" json:"security"`
}

type Tax struct {
	ID            uint    `gorm:"primaryKey"`
	UserID        uint    `gorm:"foreignKey;index:idx_tax_user_createdat"`
	MonthYear     string  `gorm:"not null;index"`
	TaxableProfit float64 `gorm:"not null"`
	TaxAmount     float64 `gorm:"not null"`
	IsPaid        bool    `gorm:"default:false"`
	CreatedAt     string  `gorm:"autoCreateTime;index:idx_tax_user_createdat"`
}

type Exchange struct {
	ID        uint   `gorm:"primaryKey" json:"id,omitempty"`
	Name      string `gorm:"not null" json:"name,omitempty"`
	Acronym   string `gorm:"not null" json:"acronym,omitempty"`
	MicCode   string `gorm:"unique;not null" json:"mic_code,omitempty"`
	Country   string `gorm:"not null" json:"country,omitempty"`
	Currency  string `gorm:"not null" json:"currency,omitempty"`
	Timezone  string `gorm:"not null" json:"timezone,omitempty"`
	OpenTime  string `gorm:"not null" json:"open_time,omitempty"`
	CloseTime string `gorm:"not null" json:"close_time,omitempty"`
}
