module cli_nft::simple_nft {
    use std::string::String;

    public struct SimpleNFT has key,store{
        id:UID,
        name: String,
        description: String,
        image_url: String,
    }
    public struct SIMPLE_NFT has drop{}

    fun init(otw:SIMPLE_NFT,ctx:&mut TxContext){
        let keys = vector[
            b"name".to_string(),
            b"description".to_string(),
            b"image_url".to_string()
        ];
        let values = vector[
            b"{name}".to_string(),
            b"{description}".to_string(),
            b"{image_url}".to_string()
        ];
        let publisher = sui::package::claim(otw,ctx);
        let mut display = sui::display::new_with_fields<SimpleNFT>(&publisher,keys,values,ctx);
        display.update_version();
        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    public fun create_simple_nft(name: String, ctx: &mut TxContext){
        let simpleNft = SimpleNFT {
            id: sui::object::new(ctx),
            name,
            description: b"Simple NFT".to_string(),
            image_url: b"https://sm.pcmag.com/t/pcmag_me/review/w/world-of-w/world-of-warcraft-shadowlands-for-pc_kzkn.3840.jpg".to_string(),
        };
        transfer::public_transfer(simpleNft, ctx.sender());
    }
    
}